class Squad < ApplicationRecord
  belongs_to :user
  has_one :package
  has_many :squadmembers
  has_many :venues, through: :squadchosenvenues

  validates :user, presence: true
end
