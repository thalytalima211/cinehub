require 'rails_helper'

describe 'User search movies', type: :system do
  it 'by movie title' do
    user = create :user
    create :movie, title: 'O Poderoso Chefão', release_year: 1972, user: user
    create :movie, title: 'O Poderoso Chefão II', release_year: 1974, user: user
    create :movie, title: 'Interestelar', release_year: 2014, user: user

    visit root_path
    within('#search-movie') { fill_in 'search', with: 'Poderoso' }
    click_on 'Aplicar'

    expect(page).to have_content 'O Poderoso Chefão'
    expect(page).to have_content 'O Poderoso Chefão II'
    expect(page).not_to have_content 'Interestelar'
  end

  it 'by release year' do
    user = create :user
    create :movie, title: 'O Poderoso Chefão', release_year: 1972, user: user
    create :movie, title: 'O Poderoso Chefão II', release_year: 1972, user: user
    create :movie, title: 'Interestelar', release_year: 2014, user: user

    visit root_path
    within('#search-movie') { fill_in 'search', with: '1972' }
    click_on 'Aplicar'

    expect(page).to have_content 'O Poderoso Chefão'
    expect(page).to have_content 'O Poderoso Chefão II'
    expect(page).not_to have_content 'Interestelar'
  end

  it 'by movie director name' do
    user = create :user
    director1 = create :director, name: 'Fernando Meirelles'
    director2 = create :director, name: 'José Padilha'
    create :movie, title: 'O Poderoso Chefão', release_year: 1972, user: user, director: director1
    create :movie, title: 'O Poderoso Chefão II', release_year: 1972, user: user, director: director2
    create :movie, title: 'Interestelar', release_year: 2014, user: user, director: director1

    visit root_path
    within('#search-movie') { fill_in 'search', with: 'Fernando' }
    click_on 'Aplicar'

    expect(page).to have_content 'O Poderoso Chefão'
    expect(page).not_to have_content 'O Poderoso Chefão II'
    expect(page).to have_content 'Interestelar'
  end
end
