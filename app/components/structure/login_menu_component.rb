# frozen_string_literal: true

module Structure
  # Dropdown menu for user login/logout, used in the header
  class LoginMenuComponent < ViewComponent::Base
    def admin?
      true
    end
  end
end
