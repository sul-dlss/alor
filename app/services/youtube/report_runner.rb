# frozen_string_literal: true

module Youtube
  # ReportRunner runs the selected report for the YouTube channel
  class ReportRunner
    def initialize(channel_id:)
      @channel_id = channel_id
      @channel = Channel.find_by(channel_id: channel_id)
    end

    attr_reader :channel_id, :channel

    def caption_report_for_channel
      ReportWriter.new(channel_id:,
                       headers: caption_report_headers,
                       data: caption_report_data).write_report
    end

    private

    def caption_report_headers
      ['Video ID', 'Title', 'Duration', 'Views', 'Captioned', 'ASR Languages', 'Edited Languages', 'Uploaded At']
    end

    def caption_report_data
      channel.videos.map do |video|
        [
          video.video_id,
          video.title,
          DurationPresenter.new(duration: video.video_data['contentDetails']['duration']).translate,
          video.video_data['statistics']['viewCount'],
          video.video_data['contentDetails']['caption'],
          video.asr_languages,
          video.edited_languages,
          video.updated_at
        ]
      end
    end
  end
end
