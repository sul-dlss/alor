# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video do
  let(:channel) { create(:channel) }

  describe 'associations' do
    let(:video) { create(:video, channel:) }

    it 'belongs to a channel' do
      expect(video.channel).to eq(channel)
      expect(video.refresh_job_started_at).to be_nil
      expect(video.data).not_to be_nil
    end
  end

  describe 'when a video has data' do
    let(:video) { create(:video, data:) }
    let(:data) do
      {
        etag: 'drvitEldi8j8SFKldcNOZ8lTeh4',
        kind: 'youtube#videoListResponse',
        items: [
          {
            id: 'm2rCpXnyCnY',
            etag: 'SY5uMOp4EHMQTorOZpxT9tjal-o',
            kind: 'youtube#video',
            statistics: {
              likeCount: '1',
              viewCount: '200',
              favoriteCount: '0'
            },
            contentDetails: {
              caption: 'true',
              duration: 'PT2M31S',
              dimension: '2d',
              definition: 'hd',
              projection: 'rectangular',
              contentRating: {},
              licensedContent: false
            }
          }
        ],
        pageInfo: { totalResults: 1, resultsPerPage: 1 }
      }
    end

    it 'has video_data' do
      expect(video.video_data).not_to be_nil
    end

    it 'has video_detail' do
      expect(video.video_detail).not_to be_nil
    end

    it 'is captioned' do
      expect(video).to be_captioned
      expect(video.display_class).to eq('captioned')
    end

    it 'has a duration' do
      expect(video.duration).to eq('PT2M31S')
    end

    it 'has statistics' do
      expect(video.statistics).to be_truthy
      expect(video.view_count).to eq('200')
    end
  end

  describe 'when a video has caption data' do
    let(:video) { create(:video, caption_data:) }
    let(:caption_data) do
      {
        etag: 'zvkBqAEFA_cVh6IZbukSQm42iXg',
        kind: 'youtube#captionListResponse',
        items: [
          {
            id: 'AUieDabYkJgJnRvwGc-btH0zzmnL9RnciaCp0tUdDoR4qrgLLds',
            etag: '_knvT9GNRZ7pZXpIIILnFP4Yk70',
            kind: 'youtube#caption',
            snippet: {
              isCC: false,
              name: '',
              status: 'serving',
              isDraft: false,
              isLarge: false,
              videoId: 'm2rCpXnyCnY',
              language: 'en',
              trackKind: 'asr',
              lastUpdated: '2023-06-20T21:47:32.284816Z',
              isAutoSynced: false,
              isEasyReader: false,
              audioTrackType: 'unknown'
            }
          }, {
            id: 'AUieDaaGBOGdRMIHxFpwfV7DIwJVSvZ_pkEYg2WBgXZT',
            etag: 'zY87b1sVpEPJ1rWfQ7g73M7lsJ4',
            kind: 'youtube#caption',
            snippet: {
              isCC: false,
              name: '',
              status: 'serving',
              isDraft: false,
              isLarge: false,
              videoId: 'm2rCpXnyCnY',
              language: 'en',
              trackKind: 'standard',
              lastUpdated: '2023-06-21T19:49:17.484864Z',
              isAutoSynced: false,
              isEasyReader: false,
              audioTrackType: 'unknown'
            }
          }
        ]
      }
    end

    it 'has an asr caption track' do
      expect(video.asr_languages).to eq('en')
    end

    it 'has an edited caption track' do
      expect(video.edited_languages).to eq('en')
    end
  end
end
