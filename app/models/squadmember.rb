class Squadmember < ApplicationRecord
  belongs_to :user
  belongs_to :squad
  belongs_to :squadchosenvenue

  validates :contribution, numericality: { only_integer: true, greater_than: 0 }
  validates :will_be_present, inclusion: { in: [true, false] }

end
