# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    channel_id { 'MyString' }
    file { nil }
  end
end
