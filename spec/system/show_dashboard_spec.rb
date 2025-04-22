# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show dashboard', :rack_test do
  # TODO: Figure out how to test unauthorized access without a redirect
  #       or add a redirect to a custom unauthorized page
  # context 'when an unauthorized user visits the dashboard' do
  #   before do
  #     sign_in(create(:user))
  #   end

  #   it 'returns a 401 status' do
  #     visit root_path
  #     # expect { visit root_path }.to raise_error(ActionPolicy::Unauthorized)
  #   end
  # end

  context 'when an authorized user visits the dashboard' do
    let!(:channel) { create(:channel) }
    let(:user) { create(:user) }

    before do
      sign_in(user, groups: [Settings.authorization_workgroup_names.administrators])
    end

    it 'displays the dashboard' do
      visit root_path

      expect(page).to have_css('h2', text: 'DLSS Youtube Channels')
      expect(page).to have_text(channel.title)
    end
  end
end
