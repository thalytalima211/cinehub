require 'rails_helper'

describe MovieImportJob, type: :job do
  include ActiveJob::TestHelper

  it 'creates movies from a valid CSV file' do
    create :category, name: 'Ficção Científica'
    create :category, name: 'Romance'
    create :category, name: 'Drama'
    user = create :user
    file_path = Rails.root.join 'spec/support/files/movies.csv'
    import = Import.create! status: :pending, user: user
    import.file.attach io: File.open(file_path), filename: 'movies.csv', content_type: 'text/csv'

    MovieImportJob.perform_now import.id
    import.reload

    expect(import.completed?).to be true
    expect(Movie.count).to eq 5
  end

  it 'sends notification email after completion' do
    user = create :user
    create :category, name: 'Ficção Científica'
    create :category, name: 'Romance'
    create :category, name: 'Drama'

    file_path = Rails.root.join 'spec/support/files/movies.csv'
    import = Import.create! status: :pending, user: user
    import.file.attach io: File.open(file_path), filename: 'movies.csv', content_type: 'text/csv'

    perform_enqueued_jobs do
      MovieImportJob.perform_now import.id
    end

    import.reload
    expect(import.status).to eq 'completed'

    email = ActionMailer::Base.deliveries.last
    expect(email.to).to include user.email
    expect(email.subject).to include 'Importação de filmes concluída!'
  end

  it 'sent notification email if it fails' do
    user = create :user
    import = Import.create! status: :pending, user: user
    malformed_csv = StringIO.new(%(title,description,release_year\n"Inception,"A thief,2010))
    import.file.attach io: malformed_csv, filename: 'malformed.csv', content_type: 'text/csv'

    perform_enqueued_jobs do
      MovieImportJob.perform_now import.id
    end
    import.reload

    expect(import.status).to eq 'failed'
    email = ActionMailer::Base.deliveries.last
    expect(email.to).to include user.email
    expect(email.subject).to include 'Importação de filmes concluída!'
  end

  it 'marks import as failed when CSV is malformed' do
    user = create :user
    create :category, name: 'Ficção Científica'
    malformed_csv = StringIO.new(%(title,description,release_year\n"Inception,"A thief,2010))
    import = Import.create! status: :pending, user: user
    import.file.attach io: malformed_csv, filename: 'malformed.csv', content_type: 'text/csv'

    MovieImportJob.perform_now import.id
    import.reload

    expect(import.status).to eq 'failed'
    expect(import.error_message).to include 'O arquivo CSV está mal formatado'
    expect(Movie.count).to eq 0
  end

  it 'marks import as failed when CSV has no headers' do
    user = create :user
    csv_without_headers = StringIO.new ''
    import = Import.create! status: :pending, user: user
    import.file.attach io: csv_without_headers, filename: 'no_headers.csv', content_type: 'text/csv'

    MovieImportJob.perform_now import.id
    import.reload

    expect(import.status).to eq 'failed'
    expect(import.error_message).to include 'O arquivo CSV está sem cabeçalho'
  end

  it 'marks import as failed when a movie record is invalid' do
    user = create :user
    create :category, name: 'Ficção Científica'
    invalid_csv = StringIO.new("title,description,release_year,duration,director,category\n" \
                               ',A thief who steals dreams,2010,148,Christopher Nolan,Ficção Científica')
    import = Import.create! status: :pending, user: user
    import.file.attach io: invalid_csv, filename: 'invalid_movie.csv', content_type: 'text/csv'

    MovieImportJob.perform_now import.id
    import.reload

    expect(import.status).to eq 'failed'
    expect(import.error_message).to include 'registro de filme inválido'
    expect(import.error_message).to include 'Título não pode ficar em branco'
    expect(import.error_message).to match(/linha 2/)
    expect(Movie.count).to eq 0
  end

  it 'marks import as failed when a category or director is not found' do
    user = create :user
    csv_missing_category = StringIO.new("title,description,release_year,duration,director,category\n" \
                                        'Inception,A thief who steals,2010,148,Christopher Nolan,Ficção Científica')
    import = Import.create! status: :pending, user: user
    import.file.attach io: csv_missing_category, filename: 'missing_category.csv', content_type: 'text/csv'

    MovieImportJob.perform_now import.id
    import.reload

    expect(import.status).to eq 'failed'
    expect(import.error_message).to include 'Categoria não encontrada'
    expect(import.error_message).to match(/linha 2/)
    expect(Movie.count).to eq 0
  end

  it 'does not save any movies if one of them is invalid' do
    user = create :user
    create :category, name: 'Ficção Científica'
    create :category, name: 'Drama'
    csv_content = StringIO.new("title,description,release_year,duration,director,category\n" \
                               "Inception,A thief who steals dreams,2010,148,Christopher Nolan,Ficção Científica\n" \
                               ",Invalid movie,2020,120,Some Director,Ficção Científica\n" \
                               'Interstellar,Explorers travel,2014,169,Christopher Nolan,Ficção Científica')
    import = Import.create! status: :pending, user: user
    import.file.attach io: csv_content, filename: 'three_movies.csv', content_type: 'text/csv'

    MovieImportJob.perform_now import.id
    import.reload

    expect(import.status).to eq 'failed'
    expect(import.error_message).to include 'registro de filme inválido'
    expect(Movie.count).to eq 0
  end
end
