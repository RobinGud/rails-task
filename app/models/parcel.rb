class Parcel < ApplicationRecord
    validates :volume, :weight, :price, :distance_id, presence: true
    validates :volume, :weight, :price, :distance_id, numericality: true


    belongs_to :distance
    has_one :city, through: :distance

end
