# frozen_string_literal: true

module Elements
  # Displays the top breadcrumb navigation
  class BreadcrumbNavComponent < ApplicationComponent
    renders_many :breadcrumbs, types: {
      default: {
        renders: BreadcrumbComponent, as: :breadcrumb
      }
    }
  end
end
