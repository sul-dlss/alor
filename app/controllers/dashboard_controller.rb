# frozen_string_literal: true

# Controller for the user dashboard
class DashboardController < ApplicationController
  skip_verify_authorized only: :show

  def show
    logger.info "Dashboard accessed by user: #{Current.user}"
    logger.info "Current groups: #{Current.groups}}"
    @channels = Channel.all
  end
end
