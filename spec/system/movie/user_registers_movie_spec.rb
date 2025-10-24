require 'rails_helper'

describe 'User registers movie', type: :system do
  it 'sucessfully' do
    user = create :user
    create :tag, name: 'Comédia leve'
    create :tag, name: 'Baseado em histórias reais'
    create :category, name: 'Ação'

    login_as user
    visit root_path
    click_on 'Cadastrar novo filme'
    fill_in 'Título', with: 'O Poderoso Chefão'
    fill_in 'Sinopse', with: 'A saga da família Corleone, mostrando poder, família e crime organizado.'
    fill_in 'Ano de Lançamento', with: 1972
    fill_in 'Duração (em minutos)', with: 175
    fill_in 'Diretor', with: 'Fernando Meirelles'
    select 'Ação', from: 'Categoria'
    fill_in 'Tags', with: 'Comédia'
    find('#tag_suggestions li', text: 'Comédia leve').click
    fill_in 'Tags', with: 'Baseado'
    find('#tag_suggestions li', text: 'Baseado em histórias reais').click
    click_on 'Cadastrar'

    expect(page).to have_content 'Filme cadastrado com sucesso'
    expect(page).to have_content 'O Poderoso Chefão'
    expect(page).to have_content '1972'
    expect(page).to have_content '175 minutos'
    expect(page).to have_content 'Diretor: Fernando Meirelles'
    expect(page).to have_content 'Categoria: Ação'
    expect(page).to have_content 'Tags: Comédia leve, Baseado em histórias reais'
  end

  it 'with missing params' do
    user = create :user

    login_as user
    visit root_path
    click_on 'Cadastrar novo filme'
    fill_in 'Título', with: ''
    fill_in 'Sinopse', with: ''
    fill_in 'Ano de Lançamento', with: ''
    fill_in 'Duração (em minutos)', with: ''
    fill_in 'Diretor', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content 'Erro ao cadastrar o filme. Verifique os campos.'
    expect(page).to have_content 'Título não pode ficar em branco'
    expect(page).to have_content 'Sinopse não pode ficar em branco'
    expect(page).to have_content 'Ano de Lançamento não pode ficar em branco'
    expect(page).to have_content 'Duração não pode ficar em branco'
    expect(page).to have_content 'Diretor é obrigatório(a)'
    expect(page).to have_content 'Categoria é obrigatório(a)'
  end

  it 'must be authenticated' do
    visit new_movie_path

    expect(current_path).to eq new_user_session_path
  end
end
