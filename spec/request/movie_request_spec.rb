require 'rails_helper'

describe 'Authentication - Movie', type: :system do
  it 'User registers new movie and it is not authenticated' do
    post movies_path

    expect(response).to redirect_to new_user_session_path
  end

  it 'User edits movie and it is not authenticated' do
    movie = create :movie, title: 'Interestelar', release_year: 2014

    patch movie_path movie

    expect(response).to redirect_to new_user_session_path
  end

  it 'User edits movie and it is not the owner' do
    user1 = create :user, email: 'maria@email.com'
    user2 = create :user, email: 'joao@email.com'
    movie = create :movie, title: 'Interestelar', release_year: 2014, user: user1

    login_as user2
    patch movie_path movie

    expect(response).to redirect_to root_path
  end

  it 'User deletes movie and it is not authenticated' do
    movie = create :movie, title: 'Interestelar', release_year: 2014

    delete movie_path movie

    expect(response).to redirect_to new_user_session_path
  end

  it 'User deletes movie and it is not the owner' do
    user1 = create :user, email: 'maria@email.com'
    user2 = create :user, email: 'joao@email.com'
    movie = create :movie, title: 'Interestelar', release_year: 2014, user: user1

    login_as user2
    delete movie_path movie

    expect(response).to redirect_to root_path
  end
end
