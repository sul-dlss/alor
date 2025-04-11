# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show channel', :rack_test do
  # include ActionView::Helpers::SanitizeHelper

  context 'when an authorized user views a channel' do
    let(:channel) { create(:channel) }
    let(:user) { create(:user) }

    before do
      sign_in(user, groups: [Settings.authorization_workgroup_names.administrators])
    end

    it 'displays the dashboard' do
      visit channel_path(channel.channel_id)

      expect(page).to have_css('h2', text: channel.title)
      # expect(page).to have_text(channel.title)
      # expect(page).to have_text(channel.channel_id)
    end
  end
end
