# frozen_string_literal: true

# Job for creating a statistic report for the provided channel
class ChannelReportJob < ApplicationJob
  # @param [String] video_id: The video id to fetch
  # @param [Youtube::Client] client: The YouTube client to use for fetching video data
  def perform(channel_id:)
    @channel_id = channel_id
    return unless channel

    file = Youtube::ReportRunner.new(channel_id:).caption_report_for_channel
    report = Report.create(channel_id:)
    report.file.attach(
      io: File.open(file),
      filename: File.basename(file),
      content_type: 'text/csv',
      identify: false
    )
  end

  attr_reader :channel_id

  private

  def channel
    @channel ||= Channel.find_by(channel_id:)
  end
end
