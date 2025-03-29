# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::NavLinkComponent, type: :component do
  let(:component) { described_class.new(title: 'My Nav Link', path: '/test') }

  it 'renders the navigation link' do
    render_inline(component)
    expect(page).to have_css('li.nav-item')
    expect(page).to have_css('a.nav-link', count: 1)
    expect(page).to have_css('a.nav-link', text: 'My Nav Link')
  end
end
