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
  end

  def video_detail
    video_data['contentDetails']
  end

  def statistics
    video_data['statistics']
  end

  def captioned?
    return nil if video_data.nil?

    video_detail["duration"]
  end

  def duration
    return nil if video_data.nil?

    video_detail["duration"]
  end

  def statistics
    video_data['statistics']
  end

  def view_count
    statistics['viewCount']
  end

  def display_class
    video_detail["caption"] == "true" ? 'captioned' : 'not-captioned'
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
