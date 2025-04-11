# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show Video' do
  context 'when an authorized administrator views a video' do
    let(:video) { create(:video, data: video_details_fixture) }
    let(:user) { create(:user) }

    before do
      sign_in(user, groups: [Settings.authorization_workgroup_names.administrators])
    end

    it 'displays the video details' do
      get "/videos/#{video.video_id}"

      expect(response.body).to include(video.title)
      expect(response).to have_http_status(:ok)
    end
  end
end
