require 'rails_helper'

describe 'User visits homepage', type: :system do
  it 'and see all movies with posters if attached' do
    user = create :user
    movie1 = create :movie, title: "O Poderoso Chefão", release_year: 1972, user: user
    movie2 = create :movie, title: "Interestelar", release_year: 2014, user: user
    movie3 = create :movie, title: "A Origem", release_year: 2010, user: user

    movie1.poster.attach(io: File.open("spec/support/images/movie1.jpg"), filename: "movie1.jpg")
    movie2.poster.attach(io: File.open("spec/support/images/movie2.jpg"), filename: "movie2.jpg")

    visit root_path

    within('#movies-grid > div:nth-child(1)') do
      expect(page).to have_css 'img[src*="movie2.jpg"]'
      expect(page).to have_content 'Interestelar'
      expect(page).to have_content '2014'
    end

    within('#movies-grid > div:nth-child(2)') do
      expect(page).to have_css 'img[src*="movie_generic"]'
      expect(page).to have_content 'A Origem'
      expect(page).to have_content '2010'
    end

    within('#movies-grid > div:nth-child(3)') do
      expect(page).to have_css 'img[src*="movie1.jpg"]'
      expect(page).to have_content 'O Poderoso Chefão'
      expect(page).to have_content '1972'
    end
  end

  it 'and sees if there is no movie registered' do
    visit root_path

    expect(page).to have_content "Nenhum filme encontrado."
  end
end
