require 'rails_helper'

describe 'Authentication - User', type: :system do
  it 'User updates profile and is not authenticated' do
    patch profile_path

    expect(response).to redirect_to new_user_session_path
  end
end
