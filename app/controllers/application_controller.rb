# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # By default, requires authentication for all controllers.
  # To allow unauthenticated access, use the allow_unauthenticated_access method.
  # Also provides the current_user method.
  include Authentication

  # Adds an after_action callback to verify that `authorize!` has been called.
  # See https://actionpolicy.evilmartians.io/#/rails?id=verify_authorized-hooks for how to skip.
  verify_authorized

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
