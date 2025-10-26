FactoryBot.define do
  factory :import do
    status { :pending }

    trait :with_file do
      after(:build) do |import|
        next if import.file.attached?

        import.file.attach(
          io: StringIO.new("title,description,release_year,duration,director,category\nEx,Desc,2020,120,Dir,Romance"),
          filename: 'sample.csv',
          content_type: 'text/csv'
        )
      end
    end
  end
end
