class ParcelController < ApplicationController
  def index
  end

  def new
    @cities = City.all.collect
    @parcel = Parcel.new
  end
  
  def create
    @temp = City.find([params[:parcel][:from_city_id], params[:parcel][:to_city_id]]) # Костыль
    @parcel = Parcel.new({"price" => getPrice}.merge(parcel_params))
    if @parcel.save
      render :success
    else
      render file: "#{Rails.root}/public/520.html" , status: 520
    end
  end
  

  def check
    @temp = City.find([params[:from_city_id], params[:to_city_id]]) # Костыль
    render :json => {:distance => getDistance}
  end

  def success

  end

  private
  def getDistance
    require 'uri'
    require 'net/http'
    require 'openssl'
    require 'json'

    @from_city = @temp[0]
    @to_city = @temp[1]
    
    url = URI("https://router.hereapi.com/v8/routes?apiKey=lcr86qj5kE6ZDEGPKjb0vKPrik74odt4ifCNvdCvQvo&transportMode=car&origin=" + @from_city.lat.to_s + "," + @from_city.lon.to_s + "&destination=" + @to_city.lat.to_s + "," + @to_city.lon.to_s + "&return=summary")
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
    return 500 + (getDistance * (params[:volume].to_f + params[:weight].to_f))
  end

  private
  def parcel_params
    params.require(:parcel).permit(:volume, :weight, :price, :from_city_id, :to_city_id)
  end
end
