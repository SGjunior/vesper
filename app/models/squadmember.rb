class Squadmember < ApplicationRecord
  belongs_to :user
  belongs_to :squad
  # has_one :squadchosenvenue # TODO : find the difference between this and belongs_to
  belongs_to :squadchosenvenue
end
