class Movie < ApplicationRecord
  belongs_to :director
  belongs_to :category
  belongs_to :user
end
