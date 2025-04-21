# frozen_string_literal: true

# Form for a Channel
class ChannelForm < ApplicationForm
  attribute :channel_id, :string
  validates :channel_id, presence: true
end
