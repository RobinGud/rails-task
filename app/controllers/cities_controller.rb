class CitiesController < ApplicationController
  def index
  end

  def top
    sql = "
    SELECT
      cities.id, 
      cities.name,
      COUNT(cities.name) as count,
      AVG(parcels.weight) as avg_weight,
      MAX(parcels.volume) as max_volume
    FROM cities
      INNER JOIN distances
        ON cities.id = distances.from_city_id
      INNER JOIN parcels
        ON parcels.distance_id = distances.id
    GROUP BY cities.name, cities.id
    ORDER BY count DESC
    "
    @cities = ActiveRecord::Base.connection.execute(sql).to_a
    logger.info(@cities)
  end
end
