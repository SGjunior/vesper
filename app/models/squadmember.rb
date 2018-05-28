class Squadmember < ApplicationRecord
  belongs_to :user
  belongs_to :squad
  has_many :squadchosenvenues

  validates :contribution, numericality: { only_integer: true, greater_than: 0 }
end
