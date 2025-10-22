require 'rails_helper'

describe 'User comments movie', type: :system do
  it 'without being authenticated' do
    movie = create :movie

    visit movie_path movie
    fill_in 'Nome', with: 'Fernanda Passos'
    fill_in 'Conteúdo', with: 'Adoro esse filme desde criança.'
    within('#comment_rating') { select '4' }
    click_on 'Enviar'

    expect(current_path).to eq movie_path movie
    within('#comments > div:nth-child(1)') do
      expect(page).to have_content 'Fernanda Passos'
      expect(page).to have_content 'Adoro esse filme desde criança.'
      expect(page).to have_content '4'
    end
  end

  it 'while authenticated' do
    user = create :user, email: 'fernanda@email.com', name: 'Fernanda Passos'
    movie = create :movie

    login_as user
    visit movie_path movie
    fill_in 'Conteúdo', with: 'Adoro esse filme desde criança.'
    within('#comment_rating') { select '4' }
    click_on 'Enviar'

    expect(current_path).to eq movie_path movie
    within('#comments > div:nth-child(1)') do
      expect(page).to have_content 'Fernanda Passos'
      expect(page).to have_content 'Adoro esse filme desde criança.'
      expect(page).to have_content '4'
    end
  end

  it 'with missing params' do
    movie = create :movie

    visit movie_path movie
    fill_in 'Nome', with: ''
    fill_in 'Conteúdo', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Erro ao enviar o comentário. Verifique os campos.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Conteúdo não pode ficar em branco'
  end
end
