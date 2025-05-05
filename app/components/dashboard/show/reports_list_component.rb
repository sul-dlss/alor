# frozen_string_literal: true

module Dashboard
  module Show
    # Component for rendering a table of reports for a channel on the dashboard
    class ReportsListComponent < ApplicationComponent
      VIDEO_LIMIT = 5

      def initialize(channel:)
        @channel = channel
        super()
      end

      attr_reader :channel

      def id
        @id ||= dom_id(channel, 'table')
      end

      def id_for(report)
        dom_id(report, id)
      end

      def label
        'Reports'
      end

      def values_for(report)
        [
          report.created_at,
          link_to(report.file.filename, rails_blob_path(report.file.blob, disposition: 'attachment'))
        ]
      end

      def reports
        @reports ||= Report.where(channel_id: channel.channel_id).sort_by(&:created_at).reverse
      end
    end
  end
end
