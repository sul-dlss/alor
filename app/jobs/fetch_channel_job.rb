# frozen_string_literal: true

# Fetch channel data and save it to the database
class FetchChannelJob < ApplicationJob
  retry_on Google::Apis::ClientError, wait: 24.hours, attempts: 3

  # @param [String] channel_id: The channel id to fetch
  def perform(channel_id:)
    @channel_id = channel_id

    @refresh_job_started_at = Time.zone.now
    channel = Channel.find_by(channel_id:)
    return unless channel

    channel.update(channel_attrs)
    refresh_videos

    @refresh_job_started_at = nil
    channel.update(channel_attrs)
  end

  attr_reader :channel_id, :refresh_job_started_at

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
      published_date = video['snippet']['publishedAt']
      FetchVideoJob.perform_later(video_id:, title:, published_date:, channel_id:)
    end
  end

  def channel_attrs
    {
      title: channel_data['items'].first['snippet']['title'],
      data: channel_data,
      refresh_job_started_at:
    }
  end
end
