require 'rails_helper'

describe 'User sees movie details', type: :system do
  it 'sucessfully' do
    director = create :director, name: 'Fernando Meirelles'
    category = create :category, name: 'Romance'
    tag1 = create :tag, name: 'Amizade'
    tag2 = create :tag, name: 'Comédia leve'
    movie = create :movie, title: 'O Poderoso Chefão', release_year: 1972,
                           duration: 175, category: category, director: director, average_rating: 4.0
    movie.tags << tag1
    movie.tags << tag2
    movie.poster.attach(io: File.open('spec/support/images/movie1.jpg'), filename: 'movie1.jpg')

    visit root_path
    click_on 'O Poderoso Chefão'

    expect(current_path).to eq movie_path movie
    expect(page).to have_content 'O Poderoso Chefão'
    expect(page).to have_content '1972'
    expect(page).to have_content '175 minutos'
    expect(page).to have_content 'Diretor: Fernando Meirelles'
    expect(page).to have_content 'Categoria: Romance'
    expect(page).to have_content 'Tags: Amizade, Comédia leve'
  end

  it 'and sees comments and ratings' do
    user1 = create :user, email: 'joão@email.com', name: 'João Ferreira'
    user2 = create :user, email: 'maria@email.com', name: 'Maria Carvalho'
    movie = create :movie
    create :comment, movie: movie, content: 'Excelente!', rating: 5, user: user1
    create :comment, movie: movie, content: 'Muito bom', rating: 4, user: user2

    visit movie_path movie

    within('#comments > div:nth-child(1)') do
      expect(page).to have_content 'Maria Carvalho'
      expect(page).to have_content 'Muito bom'
      expect(page).to have_content '4'
    end

    within('#comments > div:nth-child(2)') do
      expect(page).to have_content 'João Ferreira'
      expect(page).to have_content 'Excelente!'
      expect(page).to have_content '5'
    end
  end
end
