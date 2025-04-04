# frozen_string_literal: true

FactoryBot.define do
  factory :channel do
    channel_id { channel_id_fixture }
    title { channel_title_fixture }
  end
end
