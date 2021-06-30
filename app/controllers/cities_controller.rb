class CitiesController < ApplicationController
  def index
  end

  def top
    sql = "
    SELECT 
      cities.id, 
      cities.name, 
      distances.id as dis_id, 
      distances.from_city_id, 
      COUNT(cities.name) as count,
      AVG(parcels.weight) as avg_weight,
      MAX(parcels.volume) as max_volume
    FROM cities
      INNER JOIN distances 
        ON cities.id = distances.from_city_id
      INNER JOIN parcels 
        ON parcels.distance_id = dis_id
    GROUP BY cities.name
    ORDER BY count DESC
    "
    @cities = ActiveRecord::Base.connection.execute(sql)
    logger.info(@cities)
  end
end
