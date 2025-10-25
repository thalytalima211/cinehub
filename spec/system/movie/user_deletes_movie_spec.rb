require 'rails_helper'

describe 'User deletes movie', type: :system do
  context 'from profile page' do
    it 'successfully' do
      user = create :user
      create :movie, title: 'Interestelar', release_year: 2014, user: user

      login_as user
      visit profile_path
      within('#movies-grid > div:nth-child(1)') { click_on 'Excluir' }
      within('#delete-modal') { click_on 'Excluir' }

      expect(page).to have_content 'Filme excluído com sucesso'
      expect(current_path).to eq profile_path
      expect(page).not_to have_content 'Interestelar'
      expect(page).not_to have_content '2014'
    end
  end
end
