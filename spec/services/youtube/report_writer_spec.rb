# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Youtube::ReportWriter do
  subject(:report_writer) { described_class.new(channel_id:, headers:, data:) }

  let(:channel_id) { 'UC1234567890' }
  let(:headers) { ['Title', 'Description', 'Published At'] }
  let(:data) do
    [
      ['Video 1', 'Description for video 1', '2023-01-01T12:00:00Z'],
      ['Video 2', 'Description for video 2', '2023-01-02T12:00:00Z'],
      ['Video 3', 'Description for video 3', '2023-01-03T12:00:00Z']
    ]
  end

  describe '.write_report' do
    let(:report_timestamp) { Time.zone.now.strftime('%Y%m%d%H%M%S') }
    let(:report_filename) { "#{channel_id}-#{report_timestamp}.csv" }
    let(:report_filepath) { File.join(Settings.reports.base_path, report_filename) }

    before do
      allow(Time.zone.now).to receive(:strftime).and_return(report_timestamp)
      report_writer.write_report
    end

    it 'writes a CSV report' do
      expect(File).to exist(report_filepath)
      csv_content = File.read(report_filepath)

      # Check if the CSV content matches the expected format
      expect(csv_content).to include(headers.join(','))
      data.each do |row|
        expect(csv_content).to include(row.join(','))
      end
    end
  end
end
