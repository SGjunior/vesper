class Squad < ApplicationRecord
  belongs_to :user
  belongs_to :package
  has_many :squadmembers
  has_many :squadchosenvenues
end
