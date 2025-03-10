class Match < ApplicationRecord
  belongs_to :guide, source: :user, if: :user.guide == true
  belongs_to :tourist, source: :user, if: :user.guide == false

  belongs_to :location
end
