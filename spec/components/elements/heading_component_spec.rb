# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::HeadingComponent, type: :component do
  it 'renders a basic h1 heading' do
    render_inline(described_class.new(level: 'h1', text: 'My H1 Heading'))

    expect(page).to have_css('h1', text: 'My H1 Heading')
  end

  it 'renders an h2 heading with an h3 variant' do
    render_inline(described_class.new(level: 'h2', text: 'My H3 Formatted H2 Heading', variant: 'h3'))

    expect(page).to have_css('h2.h3', text: 'My H3 Formatted H2 Heading')
  end

  it 'raises an error for invalid heading level' do
    expect do
      render_inline(described_class.new(level: 'h7', text: 'Invalid Heading'))
    end.to raise_error(ArgumentError, 'Invalid level')
  end
end
