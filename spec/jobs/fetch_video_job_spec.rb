# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchVideoJob do
  let(:channel) { create(:channel) }
  let(:video) { create(:video, channel:) }
  let(:client) { Youtube::Client.new(channel_id: channel.channel_id) }

  before do
    allow(Youtube::Client).to receive(:new).with(channel_id: channel.channel_id).and_return(client)
    allow(client).to receive_messages(video_data: video.data, caption_data: nil)
  end

  context 'when fetching data for a new video' do
    it 'populates video data' do
      # expect(channel.data).to eq({}) # Ensure the channel starts with no data
      described_class.perform_now(video_id: video.video_id, client:)
      expect(video.reload.data).to eq(video.data)
    end
  end
end
