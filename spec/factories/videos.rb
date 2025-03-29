# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    video_id { "video_#{SecureRandom.uuid}" }
    title { "Video #{channel.channel_id} Title" }
    channel factory: :channel

    trait :with_data do
      data do
        {
          "items": [
            {
              "contentDetails": {
                "duration": "PT1H2M30S", # Example duration
                "caption": "true" # Example caption status
              },
              "statistics": {
                "viewCount": "12345" # Example view count
              }
            }
          ]
        }
      end
    end

  end
end
