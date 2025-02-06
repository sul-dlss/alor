# frozen_string_literal: true

# Controller for the user dashboard
class DashboardController < ApplicationController
  def show
    @channels = Channel.all
  end
end
