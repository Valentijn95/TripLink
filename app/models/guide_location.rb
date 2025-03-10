class GuideLocation < ApplicationRecord
  belongs_to :guide, source: :user
  belongs_to :location
end
