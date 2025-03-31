# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::Tables::TableComponent, type: :component do
  context 'with no rows' do
    it 'does not render the table' do
      render_inline(described_class.new(id: 'test-table', label: 'Test Table'))

      expect(page).to have_no_table('test-table')
    end
  end

  context 'with headers and rows' do
    it 'renders the table' do
      render_inline(
        described_class.new(
          id: 'channels',
          label: 'Channels',
          classes: ['my-table-class'],
          body_classes: ['my-table-body-class'],
          show_label: true
        ).tap do |component|
          component.with_headers([{ label: 'Header 1' }, { label: 'Header 2' }])
          # Adding rows to the table
          component.with_row(values: ['Value 1', 'Value 2'])
        end
      )

      table = page.find('table#channels')
      expect(table).to have_css('caption', text: 'Channels')
      expect(table).to have_css('thead')
      expect(table).to have_css('th', count: 2)
      expect(table).to have_css('th', text: 'Header 1')
      expect(table).to have_css('th', text: 'Header 2')

      body = table.find('tbody')
      expect(body).to have_css('tr', count: 1)

      row = body.find('tr:nth-child(1)')
      expect(row).to have_css('td', count: 2)
      expect(row).to have_css('td', text: 'Value 1')
      expect(row).to have_css('td', text: 'Value 2')
    end
  end
end
