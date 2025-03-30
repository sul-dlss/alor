# frozen_string_literal: true

# Fetch video data and save it to the database
class FetchVideoJob < ApplicationJob
  # @param [String] video_id: The video id to fetch
  # @param [Youtube::Client] client: The YouTube client to use for fetching video data
  def perform(video_id:, client:)
    @video_id = video_id
    @client = client

    video = Video.find_by(video_id:)
    video.data = video_data
    video.caption_data = caption_data
    video.save!
  end

  attr_reader :video_id, :client

  private

  def video_data
    JSON.parse(client.video_data(video_id).to_json)
  end

  def caption_data
    JSON.parse(client.caption_data(video_id).to_json)
  end
end
