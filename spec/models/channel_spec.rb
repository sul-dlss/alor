# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channel do
  describe 'associations' do
    let(:channel) { create(:channel, videos: [video]) }
    let(:video) { create(:video) }

    it 'has a video' do
      expect(channel.videos.count).to eq(1)
      expect(channel.videos).to include(video)
    end
  end

  describe 'when a channel has no videos' do
    let(:channel) { create(:channel) }

    it 'refresh_job_started? returns false when not started' do
      expect(channel.videos.count).to eq(0)
      expect(channel).not_to be_refresh_job_started
    end
  end
end
