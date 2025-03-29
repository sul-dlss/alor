# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Show::TableHeadingComponent, type: :component do
  it 'renders the table heading' do
    render_inline(described_class.new(text: 'My Table Heading'))

    expect(page).to have_css('h2', text: 'My Table Heading')
  end
end
