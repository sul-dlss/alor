# frozen_string_literal: true

module Channels
  # Component for rendering a link to a collection as a header component.
  class HeaderLinkComponent < ApplicationComponent
    def initialize(channel:)
      @channel = channel
      @level = level
      super()
    end

    def level
      :h3
    end

    def classes
      'h4'
    end
  end
end
