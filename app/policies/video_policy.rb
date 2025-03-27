# frozen_string_literal: true

# Video policy for managing access to viewing videos
class VideoPolicy < ApplicationPolicy
  alias_rule :show?, to: :manage?

  def manage?
    true
  end
end
