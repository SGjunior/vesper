class Venue < ApplicationRecord
  has_many :packages

  validates :name, :description, :address, :music_genre, presence: true

end
