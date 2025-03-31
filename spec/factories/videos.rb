# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    video_id { "video_#{SecureRandom.uuid}" }
    title { "Video #{channel.channel_id} Title" }
    channel factory: :channel
  end
end
