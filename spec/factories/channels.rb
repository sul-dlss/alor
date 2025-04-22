# frozen_string_literal: true

FactoryBot.define do
  factory :channel do
    sequence(:channel_id) { |n| "#{channel_id_fixture}-#{n}" }
    title { channel_title_fixture }

    trait :with_videos do
      after(:create) do |channel|
        create_list(:video, 2, channel:)
      end
    end
  end
end
