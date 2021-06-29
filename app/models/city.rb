class City < ApplicationRecord
    validates :name, :wikidata_id, :lat, :lon, presence: true
    validates :lat, :lon, numericality: true

    has_many :parcels
end
