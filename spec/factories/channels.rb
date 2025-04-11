# frozen_string_literal: true

FactoryBot.define do
  factory :channel do
    channel_id { channel_id_fixture }
    title { channel_title_fixture }

    trait :with_videos do
      after(:create) do |channel|
        create_list(:video, 2, channel:)
      end
    end
  end
end
