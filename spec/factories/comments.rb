FactoryBot.define do
  factory :comment do
    content { 'Comentário interessante!' }
    rating { rand(1..5) }
    association :movie
    association :user, factory: :user

    trait :anonymous do
      user { nil }
      username { 'Anônimo' }
    end
  end
end
