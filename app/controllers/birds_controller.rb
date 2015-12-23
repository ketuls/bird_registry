class BirdsController < ApplicationController
  before_action :set_bird, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /birds/1
  # GET /birds/1.json
  def show_details
    @bird = Bird.find(params[:id])
    if @bird
      @bird = JSON.parse(@bird.to_json)
      @bird["id"]=params[:id]
      render json: @bird.except("_id"), status: :ok
    else
      render :nothing => true, status: :not_found
    end
  end
 
  # POST /birds
  # POST /birds.json
  def create
    @bird = Bird.new(bird_params)
    if @bird.save
      render json: @bird, status: :created
    else
      render json: @bird.errors, status: :unprocessable_entity 
    end
  end

  def list_all
    @birds = Bird.only(:_id).map{|x| x["_id"].to_s}
    render json: @birds, status: :ok
  end

  # DELETE /birds/1
  # DELETE /birds/1.json
  def destroy
    @bird = Bird.find(params[:id])  
    if @bird
      @bird.destroy
      render :nothing => true, status: :ok
    else
      render :nothing => true, status: :not_found
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def bird_params
    params.require(:name)
    params.require(:family)
    params.require(:continents)
    params.permit(:name, :family , :added, :visible, :continents => [])
  end
end
