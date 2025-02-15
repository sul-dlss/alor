# frozen_string_literal: true

# Controller for a Video
class VideosController < ApplicationController
  before_action :set_video, only: %i[show destroy refresh]

  def show
    authorize! @video
  end

  def refresh
    authorize! @video
    # FetchChannelJob.perform_later(channel_id: @channel.channel_id)
    redirect_to video_path(@video.video_id)
  end

  def destroy
    authorize! @video

    @video.destroy!
    redirect_to root_path
  end

  private

  def set_video
    @video = Video.find_by!(video_id: params[:video_id])
  end
end
