# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelForm do
  describe 'Channel ID Validations' do
    let(:form) { described_class.new(channel_id: 'abc-123', title:) }
    let(:title) { nil }

    context 'when saving draft with blank work type' do
      let(:title) { 'Youtube Channel Title' }

      it 'is valid' do
        expect(form).to be_valid
      end
    end

    context 'when saving with blank channel title' do
      it 'is invalid' do
        expect(form.valid?(save: true)).to be false
        expect(form.errors[:title]).to include("can't be blank")
      end
    end
  end
end
