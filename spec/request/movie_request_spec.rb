require 'rails_helper'

describe 'Authentication - Movie', type: :system do
  it 'User registers new film and is not authenticated' do
    post movies_path

    expect(response).to redirect_to new_user_session_path
  end
end
