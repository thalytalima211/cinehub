require 'rails_helper'

describe 'User filters movies', type: :system do
  it 'by release year' do
    user = create :user
    create :movie, title: 'O Poderoso Chefão', release_year: 1972, user: user
    create :movie, title: 'O Poderoso Chefão II', release_year: 1972, user: user
    create :movie, title: 'Interestelar', release_year: 2014, user: user

    visit root_path
    within('#search-movie') { select '1972', from: 'year' }
    click_on 'Aplicar'

    expect(page).to have_content 'O Poderoso Chefão'
    expect(page).to have_content 'O Poderoso Chefão II'
    expect(page).not_to have_content 'Interestelar'
  end

  it 'by director' do
    user = create :user
    director1 = create :director, name: 'Fernando Meirelles'
    director2 = create :director, name: 'José Padilha'
    create :movie, title: 'O Poderoso Chefão', release_year: 1972, user: user, director: director1
    create :movie, title: 'O Poderoso Chefão II', release_year: 1972, user: user, director: director2
    create :movie, title: 'Interestelar', release_year: 2014, user: user, director: director1

    visit root_path
    within('#search-movie') { select 'Fernando Meirelles', from: 'director' }
    click_on 'Aplicar'

    expect(page).to have_content 'O Poderoso Chefão'
    expect(page).not_to have_content 'O Poderoso Chefão II'
    expect(page).to have_content 'Interestelar'
  end

  it 'by category' do
    user = create :user
    category1 = create :category, name: 'Ação'
    category2 = create :category, name: 'Romance'
    create :movie, title: 'O Poderoso Chefão', release_year: 1972, user: user, category: category1
    create :movie, title: 'O Poderoso Chefão II', release_year: 1972, user: user, category: category1
    create :movie, title: 'Interestelar', release_year: 2014, user: user, category: category2

    visit root_path
    within('#search-movie') { select 'Ação', from: 'category' }
    click_on 'Aplicar'

    expect(page).to have_content 'O Poderoso Chefão'
    expect(page).to have_content 'O Poderoso Chefão II'
    expect(page).not_to have_content 'Interestelar'
  end
end
