class Distance < ApplicationRecord
    validates :distance, :from_city_id, :to_city_id, presence: true

    belongs_to :from_city, class_name: "City", foreign_key: :from_city_id
    belongs_to :to_city, class_name: "City", foreign_key: :to_city_id
end
