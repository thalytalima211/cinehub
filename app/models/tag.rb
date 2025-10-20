class Tag < ApplicationRecord
  has_many :movies, through: :movie_tags

  validates :name, presence: true
  validates :name, length: { maximum: 50 }
end
