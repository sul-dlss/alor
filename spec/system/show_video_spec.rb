# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show video', :rack_test do
  # include ActionView::Helpers::SanitizeHelper

  context 'when an authorized user views a video' do
    let(:video) { create(:video, data: video_details_fixture) }
    let(:user) { create(:user) }

    before do
      sign_in(user, groups: [Settings.authorization_workgroup_names.administrators])
    end

    it 'displays the dashboard' do
      visit video_path(video.video_id)

      expect(page).to have_css('h2', text: video.title)
    end
  end
end
