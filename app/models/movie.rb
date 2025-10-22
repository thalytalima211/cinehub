class Movie < ApplicationRecord
  belongs_to :director
  belongs_to :category
  belongs_to :user

  has_one_attached :poster
  has_many :comments, dependent: :destroy
  has_many :movie_tags, dependent: :destroy
  has_many :tags, through: :movie_tags

  validates :title, :description, :release_year, :duration, presence: true
  validates :title, length: { maximum: 150 }
  validates :description, length: { maximum: 2000 }
  validates :release_year, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1895,
    less_than_or_equal_to: Date.current.year
  }
  validates :duration, numericality: {
    only_integer: true,
    greater_than: 0,
    less_than_or_equal_to: 600
  }

  def update_average_rating!
    avg = comments.where.not(rating: nil).average(:rating)
    update!(average_rating: avg || 0)
  end
end
