class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user, optional: true

  validates :content, :rating, presence: true
  validates :rating, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }
  validates :username, presence: true, if: -> { user.nil? }
  validates :username, length: { maximum: 50 }
  validates :content, length: { maximum: 1000 }

  after_destroy :update_movie_average_rating
  after_save :update_movie_average_rating

  private

  def update_movie_average_rating
    movie.update_average_rating!
  end
end
