# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchChannelJob do
  let(:channel) { create(:channel) }
  let(:channel_data) { channel_data_fixture }
  let(:youtube_client) { Youtube::Client.new(channel_id: channel_id_fixture) }
  let(:videos) { [] } # This will be populated with video data if needed

  before do
    allow(Youtube::Client).to receive(:new).with(channel_id: channel.channel_id).and_return(youtube_client)
    allow(youtube_client).to receive_messages(channel_data:, videos:, video_data: nil, caption_data: nil)
  end

  context 'when fetching data for a new channel' do
    it 'populates channel data' do
      expect(channel.data).to eq({}) # Ensure the channel starts with no data
      expect(channel.refresh_job_started_at).to be_nil
      described_class.perform_now(channel_id: channel.channel_id)
      expect(Youtube::Client).to have_received(:new).with(channel_id: channel.channel_id)
      expect(channel.reload.data).to eq(channel_data)
    end
  end

  context 'when fetching data for a existing channel' do
    let(:channel) { create(:channel, data:) }
    let(:data) { channel_data_fixture }

    it 'updates the channel data' do
      expect(channel.data).to eq(data)
      described_class.perform_now(channel_id: channel.channel_id)
      expect(Youtube::Client).to have_received(:new).with(channel_id: channel.channel_id)
      expect(channel.reload.data).to eq(channel_data)
    end
  end

  context 'when fetching data for a channel with videos' do
    let(:videos) { [video_snippet_fixture, video_snippet_fixture] }

    before do
      allow(FetchVideoJob).to receive(:perform_later)
    end

    it 'populates channel data' do
      expect(channel.data).to eq({}) # Ensure the channel starts with no data
      described_class.perform_now(channel_id: channel.channel_id)
      expect(Youtube::Client).to have_received(:new).with(channel_id: channel.channel_id)
      expect(FetchVideoJob).to have_received(:perform_later).exactly(2).times
    end
  end
end
