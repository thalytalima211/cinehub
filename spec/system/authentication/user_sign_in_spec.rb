require 'rails_helper'

describe 'User sign in', type: :system do
  it 'successfylly' do
    create :user, name: 'Maria Fernanda', email: 'maria@email.com', password: 'maria123'

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'maria@email.com'
    fill_in 'Senha', with: 'maria123'
    within('#new-session') { click_on 'Entrar' }

    expect(page).to have_content 'Maria Fernanda'
    expect(page).to have_button 'Sair'
  end

  it 'and logs out' do
    create :user, name: 'Maria Fernanda', email: 'maria@email.com', password: 'maria123'

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'maria@email.com'
    fill_in 'Senha', with: 'maria123'
    within('#new-session') { click_on 'Entrar' }
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_content 'Maria Fernanda'
    expect(page).not_to have_button 'Sair'
    expect(page).to have_link 'Entrar'
  end
end
