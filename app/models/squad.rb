class Squad < ApplicationRecord
  belongs_to :user
  has_one :package
  has_many :squadmembers
  has_many :squadchosenvenues
end
