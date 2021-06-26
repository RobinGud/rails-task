class ParcelController < ApplicationController
  def index
    @cities = City.all.collect
  end

  def new
    @temp = City.find([params[:from_city_id], params[:to_city_id]])
    @from_city = @temp[0]
    @to_city = @temp[1]
    @distance = getDistance
    @volume = params[:volume].to_f
    @weight = params[:weight].to_f
    @result = 500 + (@distance * (@volume + @weight))
    @parcel = Parcel.new(volume: @volume, weight: @weight, price: @price, from_city_id: @from_city.id, to_city_id: @to_city.id)
    if @parcel.save
      render :success
    else
      render file: "#{Rails.root}/public/520.html" , status: 520
    end
  end

  def check
    @temp = City.find([params[:from_city_id], params[:to_city_id]])
    @from_city = @temp[0]
    @to_city = @temp[1]
    @distance = getDistance
    render :json => {:distance => @distance}
  end

  def success
  end

  private
  def getDistance
    require 'uri'
    require 'net/http'
    require 'openssl'
    require 'json'
    
    url = URI("https://router.hereapi.com/v8/routes?apiKey=lcr86qj5kE6ZDEGPKjb0vKPrik74odt4ifCNvdCvQvo&transportMode=car&origin=" + @from_city.lat.to_s + "," + @from_city.lon.to_s + "&destination=" + @to_city.lat.to_s + "," + @to_city.lon.to_s + "&return=summary")
    logger.info(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    
    response = http.request(request)
    body = JSON.parse(response.read_body, {:symbolize_names => true})
    length = body[:routes][0][:sections][0][:summary][:length]
    return length / 1000
  end
end
