class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :movies, dependent: :destroy
  has_many :imports, dependent: :destroy
  has_one_attached :profile_picture

  validates :name, presence: true
  validates :name, length: { maximum: 50 }
end
