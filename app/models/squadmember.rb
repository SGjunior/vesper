class Squadmember < ApplicationRecord
  belongs_to :user
  belongs_to :squad
  belongs_to :squadchosenvenue
end
