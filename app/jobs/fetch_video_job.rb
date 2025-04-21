# frozen_string_literal: true

# Fetch video data and save it to the database
class FetchVideoJob < ApplicationJob
  retry_on Google::Apis::ClientError, wait: 24.hours, attempts: 3

  # @param [String] video_id: The video id to fetch
  # @param [Youtube::Client] client: The YouTube client to use for fetching video data
  def perform(video_id:, title:, channel_id:)
    @video_id = video_id
    @title = title
    @channel_id = channel_id
    return unless channel

    Video.upsert(video_attrs, unique_by: :video_id)
  end

  attr_reader :video_id, :title, :channel_id

  private

  def client
    @client ||= Youtube::Client.new(channel_id:)
  end

  def channel
    @channel ||= Channel.find_by(channel_id:)
  end

  def data
    JSON.parse(client.video_data(video_id).to_json)
  end

  def caption_data
    JSON.parse(client.caption_data(video_id).to_json)
  end

  def video_attrs
    {
      video_id:,
      title:,
      data:,
      caption_data:,
      channel_id: channel.id
    }
  end
end
