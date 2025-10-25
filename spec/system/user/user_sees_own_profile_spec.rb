require 'rails_helper'

describe 'User sees own profile', type: :system do
  context 'from the navbar' do
    it 'and sees profile editing form and own registered movies' do
      user = create :user, name: 'Maria Fernandes', email: 'maria@email.com'
      create :movie, title: 'O Poderoso Chefão', release_year: 1972, user: user
      create :movie, title: 'Interestelar', release_year: 2014, user: user
      user.profile_picture.attach(io: File.open('spec/support/images/random_profile.jpeg'), filename: 'profile.jpeg')

      login_as user
      visit root_path
      within('nav') { click_on 'Maria Fernandes' }

      within('#profile-section') do
        expect(page).to have_css 'img[src*="profile.jpeg"]'
        expect(page).to have_field 'Nome'
        expect(page).to have_field 'E-mail'
        expect(page).to have_field 'Nova senha'
      end

      within('#movies-grid > div:nth-child(1)') do
        expect(page).to have_content 'Interestelar'
        expect(page).to have_content '2014'
        expect(page).to have_link 'Editar'
        expect(page).to have_link 'Excluir'
      end

      within('#movies-grid > div:nth-child(2)') do
        expect(page).to have_content 'O Poderoso Chefão'
        expect(page).to have_content '1972'
        expect(page).to have_link 'Editar'
        expect(page).to have_link 'Excluir'
      end
    end
  end

  it 'only if authenticated' do
    visit profile_path

    expect(current_path).to eq new_user_session_path
  end

  context 'and edits profile' do
    it 'sucessfully' do
      user = create :user, name: 'Maria Fernandes', email: 'maria@email.com'

      login_as user
      visit root_path
      within('nav') { click_on 'Maria Fernandes' }
      fill_in 'Nome', with: 'Maria Fernandes da Rocha'
      fill_in 'E-mail', with: 'maria_rocha@email.com'
      click_on 'Editar Perfil'

      expect(page).to have_content 'Perfil atualizado com sucesso!'
      expect(page).to have_content 'Maria Fernandes da Rocha'
      user.reload
      expect(user.email).to eq 'maria_rocha@email.com'
    end

    it 'with missing params' do
      user = create :user, name: 'Maria Fernandes', email: 'maria@email.com'

      login_as user
      visit root_path
      within('nav') { click_on 'Maria Fernandes' }
      fill_in 'Nome', with: ''
      fill_in 'E-mail', with: ''
      click_on 'Editar Perfil'

      expect(page).to have_content 'Erro ao atualizar perfil. Verifique os campos.'
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'E-mail não pode ficar em branco'
    end
  end

  context 'and edits password' do
    it 'sucessfully' do
      user = create :user, password: 'old_password'

      login_as user
      visit profile_path
      fill_in 'Senha atual', with: 'old_password'
      fill_in 'Nova senha', with: 'new_password'
      fill_in 'Confirme sua senha', with: 'new_password'
      click_on 'Atualizar senha'

      expect(page).to have_content 'Senha alterada com sucesso!'
    end

    it 'with missing params' do
      user = create :user, password: 'old_password'

      login_as user
      visit profile_path
      fill_in 'Senha atual', with: ''
      click_on 'Atualizar senha'

      expect(page).to have_content 'Senha atual não pode ficar em branco'
    end

    it 'and fails if current password is incorrect' do
      user = create :user, password: 'old_password'

      login_as user
      visit profile_path
      fill_in 'Senha atual', with: 'wrong_password'
      click_on 'Atualizar senha'

      expect(page).to have_content 'Senha atual não é válido'
    end

    it 'and fails if password confirmation does not match' do
      user = create :user, password: 'old_password'

      login_as user
      visit profile_path
      fill_in 'Senha atual', with: 'old_password'
      fill_in 'Nova senha', with: 'new_password'
      fill_in 'Confirme sua senha', with: 'new_password1'
      click_on 'Atualizar senha'

      expect(page).to have_content 'Confirme sua senha não é igual a Senha'
    end
  end

  it 'and edits profile picture' do
    user = create :user, password: 'old_password'
    user.profile_picture.attach io: File.open('spec/support/images/random_profile.jpeg'), filename: 'profile.jpeg'

    login_as user
    visit profile_path
    find('#camera-button').click
    attach_file 'profile_picture_input', Rails.root.join('spec/support/images/random_profile2.jpeg'), visible: false
    click_on 'Atualizar Foto'

    within('#profile-section') do
      expect(page).to have_css 'img[src*="random_profile2.jpeg"]'
    end
  end
end
