class ParcelController < ApplicationController
  def index
    @cities = City.all.collect
  end

  def new
    @from_city = City.find(params[:from_city_id])
    @to_city = City.find(params[:to_city_id])
    @distance = getDistance
    @volume = params[:volume].to_f
    @weight = params[:weight].to_f
    @result = 500 + (@distance * (@volume + @weight))
    logger.info (@distance)
    @parcel = Parcel.new(volume: @volume, weight: @weight, price: @price, from_city_id: @from_city.id, to_city_id: @to_city.id)
    if @parcel.save
      redirect_to root_path
    else
      # render :index
    end
    # logger.info ("log" + @price.to_s)
    # redirect_to root_path
    # render :index
  end

  private
    def getDistance
      require 'uri'
      require 'net/http'
      require 'openssl'
      
      url = URI("https://wft-geo-db.p.rapidapi.com/v1/geo/cities/" + @from_city.wikidata_id.to_s + "/distance?&distanceUnit=KM&toCityId=" + @to_city.wikidata_id.to_s)

      logger.info(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = '27a229d50amshc288ac68912ac5cp1c4b53jsna5581f50c2d9'
      request["x-rapidapi-host"] = 'wft-geo-db.p.rapidapi.com'
      
      response = http.request(request)
      return response.read_body.to_f
    end
end
