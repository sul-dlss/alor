# frozen_string_literal: true

# Fetch channel data and save it to the database
class FetchChannelJob < ApplicationJob
  retry_on Google::Apis::ClientError, wait: 24.hours, attempts: 3

  # @param [String] channel_id: The channel id to fetch
  def perform(channel_id:)
    @channel_id = channel_id

    @refresh_job_started_at = Time.zone.now
    results = Channel.upsert(channel_attrs, unique_by: :channel_id)
    refresh_videos

    @refresh_job_started_at = nil
    results = Channel.upsert(channel_attrs, unique_by: :channel_id)
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
      FetchVideoJob.perform_later(video_id:, title:, channel_id:)
    end
  end

  def channel_attrs
    {
      channel_id:,
      title: channel_data['items'].first['snippet']['title'],
      data: channel_data
    }
  end
end
