class Movie < ApplicationRecord
  belongs_to :director
  belongs_to :category
  belongs_to :user

  has_one_attached :poster
  has_many :comments, dependent: :destroy
  has_many :movie_tags, dependent: :destroy
  has_many :tags, through: :movie_tags

  validates :title, :description, :release_year, :duration, presence: true
  validates :title, uniqueness: true
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

  scope :by_search, lambda { |q|
    return all if q.blank?

    joins(:director).where(
      'movies.title ILIKE :q OR movies.release_year::text ILIKE :q OR directors.name ILIKE :q',
      q: "%#{q}%"
    )
  }

  scope :by_year, ->(year) { where(release_year: year) if year.present? }
  scope :by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }
  scope :by_director, ->(director_id) { where(director_id: director_id) if director_id.present? }

  def update_average_rating!
    avg = comments.where.not(rating: nil).average(:rating)
    update!(average_rating: avg || 0)
  end
end
