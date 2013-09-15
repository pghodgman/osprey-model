class BodiesController < ApplicationController
  def all
    render json: Body.all, :except=>  [:data]
  end
  def show
    render json: Body.find(params[:id]), :except=>  [:data]
  end
  def data
    body = Body.find(params[:id])
    send_data body.data, :type => 'application/octet-stream',:disposition => 'inline'
  end
end
