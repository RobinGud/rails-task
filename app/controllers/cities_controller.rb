class CitiesController < ApplicationController
  def index
  end

  def top
    sql = "SELECT cities.id, cities.name, count(name) as count  FROM \"cities\" INNER JOIN parcels ON cities.id = parcels.from_city_id GROUP BY name ORDER BY count DESC"
    @cities = ActiveRecord::Base.connection.execute(sql)
  end
end
