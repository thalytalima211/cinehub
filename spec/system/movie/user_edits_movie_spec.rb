require 'rails_helper'

describe 'User edits movie', type: :system do
  context 'from profile page' do
    it 'succesfully' do
      user = create :user
      create :category, name: 'Romance'
      create :tag, name: 'Amizade'
      create :tag, name: 'Comédia leve'
      movie = create :movie, title: 'Interestelar', release_year: 2014, user: user

      login_as user
      visit profile_path
      within('#movies-grid > div:nth-child(1)') { click_on 'Editar' }
      fill_in 'Título', with: 'O Poderoso Chefão'
      fill_in 'Sinopse', with: 'A saga da família Corleone, mostrando poder, família e crime organizado.'
      fill_in 'Ano de Lançamento', with: 1972
      fill_in 'Duração (em minutos)', with: 175
      fill_in 'Diretor', with: 'Fernando Meirelles'
      select 'Romance', from: 'Categoria'
      fill_in 'Tags', with: 'Comédia'
      find('#tag_suggestions li', text: 'Comédia leve').click
      fill_in 'Tags', with: 'Am'
      find('#tag_suggestions li', text: 'Amizade').click
      click_on 'Editar'

      expect(page).to have_content 'Filme editado com sucesso'
      expect(current_path).to eq movie_path movie
      expect(page).to have_content 'O Poderoso Chefão'
      expect(page).to have_content '1972'
      expect(page).to have_content '175 minutos'
    end

    it 'with missing params' do
      user = create :user
      create :category, name: 'Romance'
      create :tag, name: 'Amizade'
      create :tag, name: 'Comédia leve'
      create :movie, title: 'Interestelar', release_year: 2014, user: user

      login_as user
      visit profile_path
      within('#movies-grid > div:nth-child(1)') { click_on 'Editar' }
      fill_in 'Título', with: ''
      fill_in 'Sinopse', with: ''
      fill_in 'Ano de Lançamento', with: ''
      fill_in 'Duração (em minutos)', with: ''
      fill_in 'Diretor', with: ''
      click_on 'Editar'

      expect(page).to have_content 'Erro ao editar o filme. Verifique os campos.'
      expect(page).to have_content 'Título não pode ficar em branco'
      expect(page).to have_content 'Sinopse não pode ficar em branco'
      expect(page).to have_content 'Ano de Lançamento não pode ficar em branco'
      expect(page).to have_content 'Duração não pode ficar em branco'
      expect(page).to have_content 'Diretor é obrigatório(a)'
    end

    it 'only if authenticated' do
      movie = create :movie, title: 'Interestelar', release_year: 2014

      visit edit_movie_path movie

      expect(current_path).to eq new_user_session_path
    end

    it 'only if it is the movie owner' do
      user1 = create :user, email: 'maria@email.com'
      user2 = create :user, email: 'joao@email.com'
      movie = create :movie, title: 'Interestelar', release_year: 2014, user: user1

      login_as user2
      visit edit_movie_path movie

      expect(current_path).to eq root_path
      expect(page).to have_content 'Você não pode editar esse filme'
    end
  end
end
