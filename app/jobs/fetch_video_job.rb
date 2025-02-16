# frozen_string_literal: true

# Fetch video data and save it to the database
class FetchVideoJob < ApplicationJob
  # @param [String] video_id: The video id to fetch
  def perform(channel_id:, video_id:)
    @channel_id = channel_id
    @video_id = video_id

    video = Video.find_by(video_id:)
    video.data = video_data
    video.caption_data = caption_data
    video.save!
  end

  attr_reader :channel_id, :video_id

  private

  def video_data
    JSON.parse(youtube_client.video_data(video_id).to_json)
  end

  def caption_data
    JSON.parse(youtube_client.caption_data(video_id).to_json)
  end

  def youtube_client
    @youtube_client ||= Youtube::Client.new(channel_id:)
  end
end
