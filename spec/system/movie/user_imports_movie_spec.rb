require 'rails_helper'

describe 'User imports movies', type: :system do
  ActiveJob::Base.queue_adapter = :test

  it 'successfully' do
    user = create :user
    create :category, name: 'Romance'
    create :category, name: 'Ficção Científica'
    create :category, name: 'Drama'

    login_as user
    visit root_path
    click_on 'Importar Filmes em CSV'
    attach_file 'import_file', Rails.root.join('spec/support/files/movies.csv'), make_visible: true

    expect do
      click_on 'Enviar Arquivo'
    end.to have_enqueued_job(MovieImportJob)

    expect(current_path).to eq imports_path
    expect(page).to have_content 'Arquivo CSV enviado com sucesso!'
    expect(page).to have_content 'Você receberá um e-mail quando a importação for concluída.'
  end

  it 'with missing file' do
    user = create :user

    login_as user
    visit new_import_path

    click_on 'Enviar Arquivo'

    expect(page).to have_content 'Arquivo não pode ficar em branco'
  end

  it 'and must be authenticated' do
    visit new_import_path

    expect(current_path).to eq new_user_session_path
  end

  context 'and views import history' do
    it 'successfully' do
      user = create :user

      create :import, :with_file, user: user, created_at: 3.days.ago, status: :completed
      create :import, :with_file, user: user, created_at: 2.days.ago, status: :processing
      create :import, :with_file, user: user, created_at: 1.day.ago, status: :failed,
                                  error_message: 'O arquivo CSV está sem cabeçalho'
      create :import, :with_file, user: user, created_at: 1.hour.ago, status: :failed,
                                  error_message: 'Registro de filme inválido'

      login_as user
      visit profile_path
      click_on 'Histórico de Importações'

      expect(current_path).to eq imports_path
      expect(page).to have_content 'Histórico de Importações'

      within('tbody > tr:nth-child(1)') do
        expect(page).to have_content I18n.l(1.hour.ago.to_date)
        expect(page).to have_content 'Falhou'
      end

      within('tbody > tr:nth-child(2)') do
        expect(page).to have_content I18n.l(1.day.ago.to_date)
        expect(page).to have_content 'Falhou'
        expect(page).to have_content 'O arquivo CSV está sem cabeçalho'
      end

      within('tbody > tr:nth-child(3)') do
        expect(page).to have_content I18n.l(2.days.ago.to_date)
        expect(page).to have_content 'Em Processamento'
      end

      within('tbody > tr:nth-child(4)') do
        expect(page).to have_content I18n.l(3.days.ago.to_date)
        expect(page).to have_content 'Concluído'
      end
    end
  end
end
