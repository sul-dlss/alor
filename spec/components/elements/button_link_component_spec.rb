# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::ButtonLinkComponent, type: :component do
  it 'renders the button link' do
    render_inline(described_class.new(link: 'http://www.example.com', label: 'Example Link'))

    expect(page).to have_css('a.btn', text: 'Example Link')
  end
end
