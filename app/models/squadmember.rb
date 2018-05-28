class Squadmember < ApplicationRecord
  belongs_to :user
  belongs_to :squad
  has_one :squadchosenvenue

  validates :contribution, numericality: { only_integer: true, greater_than: 0 }
  validates :will_be_present, inlusion: { in: [true, false] }

end
