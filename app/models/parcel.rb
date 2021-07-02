class Parcel < ApplicationRecord
    validates :volume, :weight, :price, :distance_id, presence: true
    validates :volume, :weight, :price, :distance_id, numericality: true


    belongs_to :distance
    has_many :city, through: :distance, :foreign_key => :from_city_id
    has_many :city, through: :distance, :foreign_key => :to_city_id

end
