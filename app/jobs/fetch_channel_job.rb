# frozen_string_literal: true

# Fetch channel data and save it to the database
class FetchChannelJob < ApplicationJob
  # @param [String] channel_id: The channel id to fetch
  def perform(channel_id:)
    @channel_id = channel_id

    @channel = Channel.find_by(channel_id:)
    @channel.data = channel_data
    @channel.save!

    refresh_videos
  end

  attr_reader :channel_id, :channel

  private

  def client
    @client ||= Youtube::Client.new(channel_id:)
  end

  def channel_data
    JSON.parse(client.channel_data.to_json)
  end

  def refresh_videos
    client.videos.map(&:to_json).each do |video|
      video = JSON.parse(video)
      video_id = video['id']['videoId']
      title = video['snippet']['title']
      vid = Video.find_or_create_by(video_id:, title:, channel:)
      FetchVideoJob.perform_later(channel_id:, video_id:)
    end
  end
end
