class ParcelController < ApplicationController
  def index
  end

  def new
    @from_city = City.find_by(name: params[:from_city_name])
    @to_city = City.find_by(name: params[:to_city_name])
    @distance = 230 # request here
    @result = 500 + (@distance * (params[:volume].to_i + params[:weigth].to_i))
    # logger.info ("log" + @price.to_s)
    # redirect_to root_path
    render :index
  end
end
