class ChannelPolicy < ApplicationPolicy
  alias_rule :show?, :update?, :edit?, :wait?, to: :manage?

  def manage?
    true
  end
end
