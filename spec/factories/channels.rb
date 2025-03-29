# frozen_string_literal: true

FactoryBot.define do
  factory :channel do
    channel_id { "channel_#{SecureRandom.uuid}" }
    title { "Channel #{channel_id} Title" }
  end
end
