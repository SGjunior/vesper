class Package < ApplicationRecord
  belongs_to :venue
  has_many :squads
end
