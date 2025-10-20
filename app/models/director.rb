class Director < ApplicationRecord
  has_many :movies, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 50 }
end
