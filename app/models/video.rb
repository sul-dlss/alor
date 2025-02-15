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
    data['items'].first
    # puts "Channel ID: #{channel.channel_id}"

    # Rails.cache.fetch("#{cache_key_with_version}/video_data", expires_in: 7.days) do
    #   puts "NOT From CACHE: #{video_id}"
    #   # JSON.parse(File.read("/Users/amcollie/github/sul-dlss/alor_poc/storage/cache/#{video_id}"))
    #   JSON.parse(Youtube::Client.new(channel_id:).video_data.to_json)
    # end
    #   client = Youtube::Client.new(channel_id: channel.channel_id)
    #   puts "Video Data: #{client.video_data(id: video_id)}"
    # rescue Google::Apis::ClientError
    #   puts "CLIENT ERROR"
  end

  def display_class
    video_data["content_details"]["caption"] == "true" ? 'captioned' : 'not-captioned'
  end

  def asr_languages
    asr_caption_tracks = caption_data['items'].select { |caption| caption['snippet']['track_kind'] == 'asr' }
    asr_caption_tracks.map { |caption| caption['snippet']['language'] }.join(', ')
  end

  def edited_languages
    edited_caption_tracks = caption_data['items'].reject { |caption| caption['snippet']['track_kind'] == 'asr' }
    edited_caption_tracks.map { |caption| caption['snippet']['language'] }.join(', ')
  end
end
