# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show video', :rack_test do
  # include ActionView::Helpers::SanitizeHelper

  context 'when an authorized user views a video' do
    let(:video) { create(:video, :with_data) }
    let(:user) { create(:user) }

    before do
      sign_in(user)
    end

    it 'displays the dashboard' do
      visit video_path(video.video_id)

      expect(page).to have_css('h2', text: video.title)
      # expect(page).to have_text(channel.title)
      # expect(page).to have_text(channel.channel_id)
    end
  end
end
