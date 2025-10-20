require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe '#valid' do
    it 'missing params' do
      movie = Movie.new title: '', description: '', release_year: '', duration: ''

      expect(movie).not_to be_valid
      expect(movie.errors).to include :title
      expect(movie.errors).to include :description
      expect(movie.errors).to include :release_year
      expect(movie.errors).to include :duration
    end

    it 'release year must be greater than 1895' do
      movie = Movie.new release_year: 1890

      movie.valid?
      expect(movie.errors).to include :release_year
    end

    it 'release year must be less than or equal to the current year' do
      current_year = Date.current.year + 1
      movie = Movie.new release_year: current_year

      movie.valid?
      expect(movie.errors).to include :release_year
    end

    it 'release year must be between 1985 and the current year' do
      movie = Movie.new release_year: 2010

      movie.valid?
      expect(movie.errors).not_to include :release_year
    end

    it 'duration must be greater than zero' do
      movie = Movie.new duration: 0

      movie.valid?
      expect(movie.errors).to include :duration
    end

    it 'duration must be less than or equal to 600 minutes' do
      movie = Movie.new duration: 601

      movie.valid?
      expect(movie.errors).to include :duration
    end

    it 'duration must be between 1 and 600 minutes' do
      movie = Movie.new duration: 120

      movie.valid?
      expect(movie.errors).not_to include :duration
    end

    it { should validate_length_of(:title).is_at_most 150 }
    it { should validate_length_of(:description).is_at_most 2000 }
  end

  describe '#update_average_rating!' do
    it 'calculates average rating correctly' do
      movie = create :movie
      user = create :user, email: 'user_test@email.com'
      create :comment, movie: movie, rating: 4, user: user
      create :comment, movie: movie, rating: 2, user: user

      expect(movie.average_rating).to eq(3.0)
    end

    it 'updates movie average when comment is destroyed' do
      movie = create :movie
      user = create :user, email: 'user_test@email.com'
      create :comment, movie: movie, rating: 5, user: user
      comment2 = create :comment, movie: movie, rating: 1, user: user

      comment2.destroy

      expect(movie.reload.average_rating).to eq(5.0)
    end
  end
end
