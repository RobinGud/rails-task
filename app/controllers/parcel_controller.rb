class ParcelController < ApplicationController
  def index
  end

  def new
    @cities = City.all.collect
    @parcel = Parcel.new
  end
  
  def create
    @from_city_id = params[:from_city_id]
    @to_city_id = params[:to_city_id]
    logger.info(@from_city_id.length)
    if @from_city_id == "" || @to_city_id == ""
      render file: "#{Rails.root}/public/520.html" , status: 520
    else
      @distance = getDistance
      @parcel = Parcel.new({price: getPrice}.merge({distance_id: @distance[:id]}).merge(parcel_params))
      if @parcel.save
        render :success
      else
        render file: "#{Rails.root}/public/520.html" , status: 520
      end
    end
  end
  

  def check
    @from_city_id = params[:from_city_id]
    @to_city_id = params[:to_city_id]
    render :json => {:distance => getDistance[:distance]}
  end

  def success

  end

  private
  def getDistance
    d = Distance.find_by(:from_city_id => @from_city_id, :to_city_id => @to_city_id)
    if (d.nil?) 
      d = Distance.create(:distance => addDistance, :from_city_id => @from_city_id, :to_city_id => @from_city_id)
    end
    return d
  end

  private
  def addDistance
    require 'uri'
    require 'net/http'
    require 'openssl'
    require 'json'

    @temp = City.find(@from_city_id, @to_city_id)

    @from_city = @temp[0]
    @to_city = @temp[1]
    
    url = URI("https://router.hereapi.com/v8/routes?apiKey=" + 
      ENV['API_KEY'] + 
      "&transportMode=car&origin=" + 
      @from_city.lat.to_s + "," + 
      @from_city.lon.to_s + 
      "&destination=" + 
      @to_city.lat.to_s + 
      "," + 
      @to_city.lon.to_s + 
      "&return=summary")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
    request = Net::HTTP::Get.new(url)
    
    response = http.request(request)
    body = JSON.parse(response.read_body, {:symbolize_names => true})
    length = body[:routes][0][:sections][0][:summary][:length]
    return length / 1000
  end

  private
  def getPrice
    return 500 + (@distance[:distance].to_f * (params[:volume].to_f + params[:weight].to_f))
  end

  private
  def parcel_params
    params.permit(:volume, :weight)
  end
end
