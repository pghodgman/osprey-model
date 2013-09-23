class ModelsController < ApplicationController
  def all
    render json: Model.all, :except=>  [:preview]
  end
  def show
    render json: Model.find(params[:id]), :except=>  [:preview]
  end
  def bodies
    render json: Model.find(params[:id]).bodies, :except=>  [:data]
  end
  def location
    render json: Model.find(params[:id]).location, :except=>  [:image]
  end
  def levels
    render json: Model.find(params[:id]).levels, :except=>  [:uuid]
  end
  def preview
    model = Model.find(params[:id])
    send_data model.preview, :type => 'image/png',:disposition => 'inline'
  end
end
