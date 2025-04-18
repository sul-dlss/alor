# frozen_string_literal: true

# Fetch channel data and save it to the database
class FetchChannelJob < ApplicationJob
  # @param [String] channel_id: The channel id to fetch
  def perform(channel_id:)
    @channel_id = channel_id

    @channel = Channel.find_by(channel_id:)
    Channel.update(@channel.id, refresh_job_started_at: Time.zone.now)
    Channel.update(@channel.id, data: channel_data)

    refresh_videos

    Channel.update(@channel.id, refresh_job_started_at: nil)
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
      Video.find_or_create_by(video_id:, title:, channel:)
      FetchVideoJob.perform_later(video_id:, client:)
    end
  end
end
