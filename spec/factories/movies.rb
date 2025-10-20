# spec/factories/movies.rb
FactoryBot.define do
  factory :movie do
    title { 'Oppenheimer' }
    description { 'Filme sobre o desenvolvimento da bomba atômica' }
    release_year { 2023 }
    duration { 180 }
    average_rating { 4.5 }

    association :director
    association :category
    association :user
  end
end
