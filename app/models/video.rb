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
    return false if data.empty?

    data['items'].first
  end

  def video_detail
    return false unless video_data

    video_data['contentDetails']
  end

  def captioned?
    return false unless video_data

    video_detail['caption']
  end

  def duration
    return false unless video_data

    video_detail['duration']
  end

  def statistics
    return false unless video_data

    video_data['statistics']
  end

  def view_count
    return false unless statistics

    statistics['viewCount']
  end

  def display_class
    return false unless video_detail

    captioned? ? 'captioned' : 'not-captioned'
  end

  def asr_languages
    asr_caption_tracks = caption_data['items'].select { |caption| caption['snippet']['trackKind'] == 'asr' }
    asr_caption_tracks.map { |caption| caption['snippet']['language'] }.join(', ')
  end

  def edited_languages
    edited_caption_tracks = caption_data['items'].reject { |caption| caption['snippet']['trackKind'] == 'asr' }
    edited_caption_tracks.map { |caption| caption['snippet']['language'] }.join(', ')
  end
end
