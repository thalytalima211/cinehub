require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#valid' do
    it 'missing params' do
      comment = Comment.new content: '', rating: '', username: ''

      expect(comment).not_to be_valid
      expect(comment.errors).to include :content
      expect(comment.errors).to include :rating
      expect(comment.errors).to include :username
    end

    it 'valid when user is present' do
      user = create :user
      movie = create :movie, user: user
      comment = Comment.new content: 'Ótimo filme', rating: 5, user: user, username: '', movie: movie

      expect(comment).to be_valid
      expect(comment.errors[:username]).to be_empty
    end

    it 'rating must be greater than or equal to 1' do
      comment = Comment.new rating: 0

      comment.valid?
      expect(comment.errors).to include :rating
    end

    it 'rating must be less than or equal to 5' do
      comment = Comment.new rating: 6

      comment.valid?
      expect(comment.errors).to include :rating
    end

    it 'rating must be between 1 and 5' do
      comment = Comment.new rating: 3

      comment.valid?
      expect(comment.errors).not_to include :rating
    end

    it { should validate_length_of(:username).is_at_most 50 }
    it { should validate_length_of(:content).is_at_most 1000 }
  end
end
