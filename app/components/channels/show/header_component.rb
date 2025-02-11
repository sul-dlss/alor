# frozen_string_literal: true

module Channels
  module Show
    # Component for rendering a channel show page header.
    class HeaderComponent < ApplicationComponent
      def initialize(presenter:)
        @presenter = presenter
        super()
      end
      attr_reader :presenter

      delegate :title, to: :presenter
    end
  end
end
