# frozen_string_literal: true

# Fetch a channel save it to the database potentially
# caching the video data result
class FetchChannelJob < ApplicationJob
  # @param [Channel] channel
  # @param [String] video_id
  def perform(channel_id:)
    @channel_id = channel_id

    puts "Channel ID: #{channel_id}"
    # filename = "/Users/amcollie/github/sul-dlss/alor_poc/storage/cache/#{channel_id}"
    # file = File.read(filename)
    # channel = Youtube::Client.new(channel_id: args[:channel_id])

    # puts "#{channel.channel_data.items.first.to_h}"
    # puts "#{channel.videos}"
    @channel = Channel.find_or_create_by(channel_id:, title: "Stanford University Libraries Digital Library Systems & Services")
    channel.data = channel_data
    channel.save!

    # channel_data = JSON.parse(file)
    # channel_data['videos'].each do |video|
    #   Video.create!(video_id: video['id']['videoId'], title: video['snippet']['title'], channel:)
    # end
  end

  attr_reader :channel_id, :channel

  private

  def channel_data
    Rails.cache.fetch("#{channel.cache_key_with_version}/channel_data", expires_in: 7.days) do
      puts "NOT From CACHE: #{channel_id}"
      JSON.parse(Youtube::Client.new(channel_id:).channel_data.to_json)
    end
  end
end
