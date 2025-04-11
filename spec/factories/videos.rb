# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    video_id { "video_#{SecureRandom.uuid}" }
    title { "Video #{channel.channel_id} Title" }
    data do
      {
        'items' => [{
          'contentDetails' => {
            'duration' => 'PT1H2M30S',
            'caption' => 'true'
          },
          'statistics' => {
            'viewCount' => '1000'
          }
        }]
      }
    end
    caption_data do
      {
        'items' => [{
          'snippet' => {
            'trackKind' => 'asr',
            'language' => 'en'
          }
        }]
      }
    end
    channel factory: :channel
  end
end
