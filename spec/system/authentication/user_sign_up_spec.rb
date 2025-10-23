require 'rails_helper'

describe 'User sign up', type: :system do
  it 'successfully' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Thalyta'
    fill_in 'E-mail', with: 'thalyta@email.com'
    fill_in 'Senha', with: 'senha123'
    fill_in 'Confirme sua senha', with: 'senha123'
    click_on 'Cadastrar-se'

    expect(page).to have_content 'Thalyta'
    expect(page).to have_button 'Sair'
  end

  it 'with missing params' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    click_on 'Cadastrar-se'

    expect(page).to have_content 'Não foi possível concluir o cadastro'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
  end
end
