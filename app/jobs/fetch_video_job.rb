# frozen_string_literal: true

# Fetch a video from a channel and save it to the database
# Potentially caching the video data result
class FetchVideoJob < ApplicationJob
  # @param [Channel] channel
  # @param [String] video_id
  def perform(channel:, video_id)
    @channel = channel
    @video_id = video_id
