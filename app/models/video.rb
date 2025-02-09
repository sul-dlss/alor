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
end
