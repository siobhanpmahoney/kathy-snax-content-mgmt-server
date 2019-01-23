class Api::V1::BiosController < ApplicationController

  def index
    @bios = Bio.all
    render json: @bios
  end

  def create
    @bio = Bio.new(bio_params)
    if @bio.save
      render json: @bio, status: 201
    else
      render json: {error: @bio.errors.full_messages}, status: 500
    end
  end


  def show
    @bio = Bio.find(params[:id])
    render json: @bio, status: :ok
  end


  def update
    @bio = Bio.find(params[:id])
    @bio.update(bio_params)
    if @bio.save
      render json: @bio
    else
      render json: {error: @bio.errors.full_messages}
    end
  end

  def destroy
    @bio = Bio.find(params[:id])
    @bio.destroy
    render json: {message:"Bio Deleted"}
  end



  private

  def bio_params
    params.require(:bio).permit(:content)
  end

end
