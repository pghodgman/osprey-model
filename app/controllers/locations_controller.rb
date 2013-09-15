class LocationsController < ApplicationController
  def all
    render json: Location.all, :except=>  [:image]
  end
  def show
    render json: Location.find(params[:id]), :except=>  [:image]
  end
  def image
    location = Location.find(params[:id])
    send_data location.image, :type => 'application/octet-stream',:disposition => 'inline'
  end
end
