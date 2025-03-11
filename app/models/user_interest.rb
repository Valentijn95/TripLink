class UserInterest < ApplicationRecord
  belongs_to :interest
  belongs_to :user

  validates :interest, uniqueness: { scope: :user_id }
end
