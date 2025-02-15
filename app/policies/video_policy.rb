class VideoPolicy < ApplicationPolicy
  alias_rule :show?, to: :manage?

  def manage?
    true
  end
end
