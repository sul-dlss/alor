class ChannelPolicy < ApplicationPolicy
  alias_rule :show?, :new?, :update?, :edit?, :wait?, to: :manage?

  def manage?
    true
  end
end
