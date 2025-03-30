# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchChannelJob do
  let(:channel) { create(:channel) }
  let(:channel_data) do
    {
      "etag" => "QshQCL9fqFZ3rmIKAIXZ189DHZ4",
      "kind" => "youtube#channelListResponse",
      "items" =>
        [
          {
            "id" => "UCc2CQuHkhKGZ-2ZLTZVGE2A",
            "etag" => "d4aRFIkWQr7YZut_TL0LUVxtWck",
            "kind" => "youtube#channel",
            "snippet" => {
              "title" => "Stanford University Libraries Digital Library Systems & Services",
              "customUrl" => "@stanforduniversitylibraries",
              "localized" => {"title" => "Stanford University Libraries Digital Library Systems & Services", "description" => ""},
              "thumbnails" => {
                "high" => {"url" => "https://yt3.ggpht.com/ytc/AIdro_n_9UX_AdCsy7Mus-Ad45LjQcc6LalHIurOeS6Bdnl_zA=s800-c-k-c0x00ffffff-no-rj", "width" => 800, "height" => 800},
                "medium" => {"url" => "https://yt3.ggpht.com/ytc/AIdro_n_9UX_AdCsy7Mus-Ad45LjQcc6LalHIurOeS6Bdnl_zA=s240-c-k-c0x00ffffff-no-rj", "width" => 240, "height" => 240},
                "default" => {"url" => "https://yt3.ggpht.com/ytc/AIdro_n_9UX_AdCsy7Mus-Ad45LjQcc6LalHIurOeS6Bdnl_zA=s88-c-k-c0x00ffffff-no-rj", "width" => 88, "height" => 88}
              },
              "description" => "",
              "publishedAt" => "2014-02-07T18:55:51Z"
            }
          }
        ],
        "pageInfo" => {"totalResults" => 1, "resultsPerPage" => 5}
    }
  end
  let(:youtube_client) { Youtube::Client.new(channel_id: channel.channel_id) }
  let(:videos) { [] } # This will be populated with video data if needed

  before do
    allow(Youtube::Client).to receive(:new).with(channel_id: channel.channel_id).and_return(youtube_client)
    allow(youtube_client).to receive(:channel_data).and_return(channel_data)
    allow(youtube_client).to receive(:videos).and_return(videos)
    allow(youtube_client).to receive(:video_data)
    allow(youtube_client).to receive(:caption_data)
  end

  context 'when fetching data for a new channel' do
    it 'populates channel data' do
      expect(channel.data).to eq({}) # Ensure the channel starts with no data
      described_class.perform_now(channel_id: channel.channel_id)
      expect(Youtube::Client).to have_received(:new).with(channel_id: channel.channel_id)
      expect(channel.reload.data).to eq(channel_data)
    end
  end

  context 'when fetching data for a existing channel' do
    let(:channel) { create(:channel, data:) }
    let(:data) do
      {
        "etag" => "QshQCL9fqFZ3rmIKAIXZ189DHZ4",
        "kind" => "youtube#channelListResponse",
        "items" =>
          [
            {
              "id" => "UCc2CQuHkhKGZ-2ZLTZVGE2A",
              "etag" => "d4aRFIkWQr7YZut_TL0LUVxtWck",
              "kind" => "youtube#channel",
              "snippet" => {
                "title" => "Stanford University Libraries Digital Library Systems & Services",
                "customUrl" => "@stanforduniversitylibraries",
                "localized" => {"title" => "Stanford University Libraries Digital Library Systems & Services", "description" => ""},
                "thumbnails" => {
                  "high" => {"url" => "https://yt3.ggpht.com/ytc/AIdro_n_9UX_AdCsy7Mus-Ad45LjQcc6LalHIurOeS6Bdnl_zA=s800-c-k-c0x00ffffff-no-rj", "width" => 800, "height" => 800},
                  "medium" => {"url" => "https://yt3.ggpht.com/ytc/AIdro_n_9UX_AdCsy7Mus-Ad45LjQcc6LalHIurOeS6Bdnl_zA=s240-c-k-c0x00ffffff-no-rj", "width" => 240, "height" => 240},
                  "default" => {"url" => "https://yt3.ggpht.com/ytc/AIdro_n_9UX_AdCsy7Mus-Ad45LjQcc6LalHIurOeS6Bdnl_zA=s88-c-k-c0x00ffffff-no-rj", "width" => 88, "height" => 88}
                },
                "description" => "",
                "publishedAt" => "2010-01-01T00:00:000"
              }
            }
          ],
          "pageInfo" => {"totalResults" => 1, "resultsPerPage" => 5}
      }
    end

    it 'updates the channel data' do
      expect(channel.data).to eq(data)
      described_class.perform_now(channel_id: channel.channel_id)
      expect(Youtube::Client).to have_received(:new).with(channel_id: channel.channel_id)
      expect(channel.reload.data).to eq(channel_data)
    end
  end

  context 'when fetching data for a channel with videos' do
    let(:videos) do
      [
        {
          "etag": "ReWpzZCFWMLB0biq_hFODrlS2pA",
          "id": {
            "kind": "youtube#video",
            "videoId": "UHkiBPk8Bl4"
          },
          "kind": "youtube#searchResult",
          "snippet": {
            "channelId": "UCc2CQuHkhKGZ-2ZLTZVGE2A",
            "channelTitle": "Stanford University Libraries Digital Library Systems & Services",
            "description": "",
            "liveBroadcastContent": "none",
            "publishedAt": "2023-07-21T23:42:29Z",
            "thumbnails": {
              "default": {
                "height": 90,
                "url": "https://i.ytimg.com/vi/UHkiBPk8Bl4/default.jpg",
                "width": 120
              },
              "high": {
                "height": 360,
                "url": "https://i.ytimg.com/vi/UHkiBPk8Bl4/hqdefault.jpg",
                "width": 480
              },
              "medium": {
                "height": 180,
                "url": "https://i.ytimg.com/vi/UHkiBPk8Bl4/mqdefault.jpg",
                "width": 320
              }
            },
            "title": "Enumeration"
          }
        },
        {
          "etag": "3NhJizXRKy2y3WgBFi07I2n8oWs",
          "id": {
            "kind": "youtube#video",
            "videoId": "p-jI5hMaBwY"
          },
          "kind": "youtube#searchResult",
          "snippet": {
            "channelId": "UCc2CQuHkhKGZ-2ZLTZVGE2A",
            "channelTitle": "Stanford University Libraries Digital Library Systems & Services",
            "description": "Basic display settings and options to make OCLC Connexion client easier to read and navigate Continuation of Stanford's OCLC ...",
            "liveBroadcastContent": "none",
            "publishedAt": "2023-06-13T21:49:58Z",
            "thumbnails": {
              "default": {
                "height": 90,
                "url": "https://i.ytimg.com/vi/p-jI5hMaBwY/default.jpg",
                "width": 120
              },
              "high": {
                "height": 360,
                "url": "https://i.ytimg.com/vi/p-jI5hMaBwY/hqdefault.jpg",
                "width": 480
              },
              "medium": {
                "height": 180,
                "url": "https://i.ytimg.com/vi/p-jI5hMaBwY/mqdefault.jpg",
                "width": 320
              }
            },
            "title": "Display Setup in OCLC Connexion Client (Stanford FOLIO Training)"
          }
        }
      ]
    end

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
