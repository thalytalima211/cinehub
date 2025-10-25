namespace :db do
  desc "Run seeds only if the bank is empty"
  task seed_if_empty: :environment do
    if Movie.count == 0
      puts "Empty database! Running seeds..."
      Rake::Task["db:seed"].invoke
    else
      puts "Database already contains data. Skipping seeds."
    end
  end
end
