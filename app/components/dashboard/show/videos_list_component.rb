# frozen_string_literal: true

module Dashboard
  module Show
    # Component for rendering a table of videos on the dashboard
    class VideosListComponent < ApplicationComponent
      VIDEO_LIMIT = 5

      def initialize(channel:)
        @channel = channel
        super()
      end

      attr_reader :channel

      def id
        @id ||= dom_id(channel, 'table')
      end

      def id_for(video)
        dom_id(video, id)
      end

      def label
        'Videos'
      end

      def values_for(video)
        [
          link_to(video.title, video_path(video.video_id)),
          DurationPresenter.new(duration: video.duration).translate,
          video.view_count,
          video.captioned?,
          video.published_date&.strftime('%m/%d/%Y')
        ]
      end

      def videos
        @videos ||= channel.videos
      end
    end
  end
end
