class Api::V1::AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.all
    render json: @announcements
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      render json: @announcement, status: 201
    else
      render json: {error: @announcement.errors.full_messages}, status: 500
    end
  end


  def show
    @announcement = Announcement.find(params[:id])
    render json: @announcement, status: :ok
  end


  def announcement
    @announcement = Announcement.find(params[:id])
    @announcement.announcement(announcement_params)
    if @announcement.save
      render json: @announcement
    else
      render json: {error: @announcement.errors.full_messages}
    end
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    render json: {message:"Announcement Deleted"}
  end



  private

  def announcement_params
    params.require(:announcement).permit(:headline, :content, :img_link, :audio_link, :embed_link, :video_link)
  end
end
