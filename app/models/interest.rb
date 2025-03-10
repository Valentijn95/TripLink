class Interest < ApplicationRecord
  has_many :guides, through: :user_interests, source: :user, if: :user.guide == true
end
