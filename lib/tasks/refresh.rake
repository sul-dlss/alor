# frozen_string_literal: true

require 'config'
require 'debug'

require_relative '../../config/boot'

namespace :refresh do
  task :channel, [:channel_id] => :environment do |_t, args|
    args.with_defaults(channel_id: Settings.youtube.channel_id)
    puts "Channel ID: #{args[:channel_id]}"
    client = Youtube::Client.new(channel_id: args[:channel_id])
    client.channel_data
  end

  task :videos, [:channel_id] => :environment do |_t, args|
    args.with_defaults(channel_id: Settings.youtube.channel_id)
    puts "Channel ID: #{args[:channel_id]}"
    # OLD Path: /Users/amcollie/github/sul-dlss/alor_poc/storage/cache/UCc2CQuHkhKGZ-2ZLTZVGE2A
    filename = "/Users/amcollie/github/sul-dlss/alor_poc/storage/cache/#{args[:channel_id]}"
    file = File.read(filename)
    client = Youtube::Client.new(channel_id: args[:channel_id])

    # puts "#{channel.channel_data.items.first.to_h}"
    # puts "#{channel.videos}"
    channel = Channel.find_or_create_by(channel_id: args[:channel_id], title: "Stanford University Libraries Digital Library Systems & Services")

    # Creating from cache
    # channel_data = JSON.parse(file)
    # channel_data['videos'].each do |video|
    #   Video.create!(video_id: video['id']['videoId'], title: video['snippet']['title'], channel:)
    # end

    channel.videos.each do |video|
      puts "Video ID: #{video.video_id} - #{video.title}"
      video.data = JSON.parse(client.video_data(video.video_id).to_json)
      video.caption_data = JSON.parse(client.caption_data(video.video_id).to_json)
      video.save!
    end
  end

  task :db, [:channel_id] => :environment do |_t, args|
    args.with_defaults(channel_id: Settings.youtube.channel_id)
    puts "Channel ID: #{args[:channel_id]}"
    client = Youtube::Client.new(channel_id: args[:channel_id])
    channel = Channel.find_or_create_by(channel_id: args[:channel_id], title: "Stanford University Libraries Digital Library Systems & Services")

    channel.videos.where(data: {}).each do |video|
      puts "Video ID: #{video.video_id} - #{video.title}"
      video.data = JSON.parse(client.video_data(video.video_id).to_json)
      video.caption_data = JSON.parse(client.caption_data(video.video_id).to_json)
      video.save!
    end
  end

  task :list_videos, [:channel_id] => :environment do |_t, args|
    args.with_defaults(channel_id: Settings.youtube.channel_id)
    puts "Channel ID: #{args[:channel_id]}"
    client = Youtube::Client.new(channel_id: args[:channel_id])
    channel = Channel.find_or_create_by(channel_id: args[:channel_id], title: "Stanford University Libraries Digital Library Systems & Services")

    File.open('tmp/videos.json', 'w') do |f|
      f.write(JSON.pretty_generate(client.videos))
    end
  end

  task :check_videos, [:channel_id] => :environment do |_t, args|
    args.with_defaults(channel_id: Settings.youtube.channel_id)
    puts "Channel ID: #{args[:channel_id]}"
    channel = Channel.find_by(channel_id: args[:channel_id])
    filename = "tmp/videos.json"
    file = File.read(filename)
    videos = JSON.parse(file)

    puts "Videos: #{videos.count}"
    videos.each do |video|
      vid = Video.find_by(video_id: video['id']['videoId'])
      if vid.nil?
        vid = Video.create!(video_id: video['id']['videoId'], title: video['snippet']['title'], channel:)
        puts "Video ID: #{vid.video_id} - #{vid.title}"
      end
    end
  end
end
