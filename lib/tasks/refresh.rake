# frozen_string_literal: true

require 'config'
require 'debug'

require_relative '../../config/boot'

namespace :refresh do
  task :videos, [:channel_id] => :environment do |_t, args|
    args.with_defaults(channel_id: Settings.youtube.channel_id)
    puts "Channel ID: #{args[:channel_id]}"
    # OLD Path: /Users/amcollie/github/sul-dlss/alor_poc/storage/cache/UCc2CQuHkhKGZ-2ZLTZVGE2A
    filename = "/Users/amcollie/github/sul-dlss/alor_poc/storage/cache/#{args[:channel_id]}"
    file = File.read(filename)
    # channel = Youtube::Client.new(channel_id: args[:channel_id])

    # puts "#{channel.channel_data.items.first.to_h}"
    # puts "#{channel.videos}"
    channel = Channel.find_or_create_by(channel_id: args[:channel_id], title: "Stanford University Libraries Digital Library Systems & Services")

    channel_data = JSON.parse(file)
    channel_data['videos'].each do |video|
      Video.create!(video_id: video['id']['videoId'], title: video['snippet']['title'], channel:)
    end
  end
end
