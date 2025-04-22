# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelForm do
  describe 'Channel ID Validations' do
    let(:form) { described_class.new(channel_id:) }
    let(:channel_id) { nil }

    context 'when saving a new channel' do
      let(:channel_id) { 'abc-123' }

      it 'is valid' do
        expect(form).to be_valid
      end
    end

    context 'when saving a channel without an ID' do
      it 'is invalid' do
        expect(form.valid?(save: true)).to be false
        expect(form.errors[:channel_id]).to include("can't be blank")
      end
    end
  end
end
