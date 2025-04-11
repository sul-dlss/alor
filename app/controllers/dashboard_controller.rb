# frozen_string_literal: true

# Controller for the user dashboard
class DashboardController < ApplicationController
  def show
    authorize! :dashboard

    @channels = Channel.all
  end
end
