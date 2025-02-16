# frozen_string_literal: true

# Fetch channel data and save it to the database
class FetchChannelJob < ApplicationJob
  # @param [String] channel_id: The channel id to fetch
  def perform(channel_id:)
    @channel_id = channel_id

    @channel = Channel.find_by(channel_id:)
    channel.data = channel_data
    channel.save!
  end

  attr_reader :channel_id

  private

  def channel_data
    JSON.parse(Youtube::Client.new(channel_id:).channel_data.to_json)
  end
end
