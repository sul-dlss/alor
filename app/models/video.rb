# frozen_string_literal: true

# Model for a Video.
class Video < ApplicationRecord
  belongs_to :channel

  # deposit_job_started_at indicates that the job is queued or running.
  # User should be "waiting" until the job is completed.
  def refresh_job_started?
    refresh_job_started_at.present?
  end

  def refresh_job_finished?
    refresh_job_started_at.nil?
  end

  def video_data
    puts "Channel ID: #{channel.channel_id}"

    Rails.cache.fetch("#{cache_key_with_version}/video_data", expires_in: 7.days) do
      puts "NOT From CACHE: #{video_id}"
      JSON.parse(File.read("/Users/amcollie/github/sul-dlss/alor_poc/storage/cache/#{video_id}"))
    end
    #   client = Youtube::Client.new(channel_id: channel.channel_id)
    #   puts "Video Data: #{client.video_data(id: video_id)}"
    # rescue Google::Apis::ClientError
    #   puts "CLIENT ERROR"
  end

  def display_class
    video_data["content_details"]["caption"] == "true" ? 'captioned' : 'not-captioned'
  end
end
