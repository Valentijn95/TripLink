class User < ApplicationRecord

  has_many :user_interests, dependent: :destroy
  has_many :interests, through: :user_interests

  has_many :guide_locations, dependent: :destroy
  has_many :locations, through: :guide_locations

  has_many :guide_matches, class_name: 'Match', foreign_key: 'guide_id'
  has_many :tourist_matches, class_name: 'Match', foreign_key: 'tourist_id'

  has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, :password, presence: true
  validates :guide_description, :rate, presence: true, if: :guide?

end
