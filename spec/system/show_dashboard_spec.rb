# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show dashboard', :rack_test do
  # include ActionView::Helpers::SanitizeHelper

  context 'when an authorized user visits the dashboard' do
    let!(:channel) { create(:channel) }
    let(:user) { create(:user) }

    before do
      sign_in(user)
    end

    it 'displays the dashboard' do
      visit root_path

      expect(page).to have_css('h2', text: 'DLSS Youtube Channels')
      expect(page).to have_text(channel.title)
      expect(page).to have_text(channel.channel_id)
    end
  end
end
