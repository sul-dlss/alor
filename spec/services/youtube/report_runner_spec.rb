# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Youtube::ReportRunner do
  subject(:report_runner) { described_class.new(channel_id: channel_id_fixture) }

  describe '.caption_report_for_channel' do
    let(:report_timestamp) { Time.zone.now.strftime('%Y%m%d%H%M%S') }
    let(:report_filename) { "#{channel_id_fixture}-#{report_timestamp}.csv" }
    let(:report_filepath) { File.join(Settings.reports.base_path, report_filename) }

    before do
      allow(Time.zone.now).to receive(:strftime).and_return(report_timestamp)
      create(:channel, :with_videos, channel_id: channel_id_fixture)
      report_runner.caption_report_for_channel
    end

    it 'runs a CSV report for the channel' do
      expect(File).to exist(report_filepath)
      csv_content = File.read(report_filepath)
      expect(csv_content).to include('Video ID,Title,Duration,Views,Captioned,ASR Languages,Edited Languages')
      # expect(csv_content).to include(video.video_id)
    end
  end
end
