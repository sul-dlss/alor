# frozen_string_literal: true

FactoryBot.define do
  factory :youtube_video_snippet do
    channel_id { channel_id_fixture }
    title { channel_title_fixture }
  end
end
