class User < ApplicationRecord
  has_one_attached :photo
  has_many :user_interests, dependent: :destroy
  has_many :interests, through: :user_interests

  has_many :guide_locations, dependent: :destroy
  has_many :locations, through: :guide_locations

  has_many :guide_matches, class_name: 'Match', foreign_key: 'guide_id', dependent: :destroy
  has_many :tourist_matches, class_name: 'Match', foreign_key: 'tourist_id', dependent: :destroy

  has_many :guides, through: :tourist_matches, class_name: 'User', foreign_key: 'guide_id'
  has_many :tourists, through: :guide_matches, class_name: 'User', foreign_key: 'tourist_id'

  has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, presence: true
  validates :password, presence: true, unless: -> { password.blank? }
  validates :guide_description, :rate, presence: true, if: :guide?

  def users_with_shared_interests
    User.joins(:user_interests)
        .where(user_interests: { interest_id: self.interest_ids })
        .where.not(id: self.id)
        .select("users.*, COUNT(user_interests.interest_id) AS shared_interests_count")
        .group("users.id")
        .order("shared_interests_count DESC")
  end
end
