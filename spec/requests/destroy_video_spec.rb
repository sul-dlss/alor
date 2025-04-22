# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Destroy Video' do
  context 'when the user is authorized' do
    let(:video) { create(:video) }

    before do
      sign_in(create(:user), groups: [Settings.authorization_workgroup_names.administrators])
    end

    it 'destroys the video' do
      expect(Video.where(video_id: video.video_id)).to exist
      delete "/videos/#{video.video_id}"

      expect(response).to have_http_status(:found)
      expect(Video.where(video_id: video.video_id)).not_to exist
    end
  end
end
