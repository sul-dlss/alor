# frozen_string_literal: true

# Channel policy for managing channel access and actions
class ChannelPolicy < ApplicationPolicy
  alias_rule :show?, :new?, :update?, :edit?, :wait?, to: :manage?

  def manage?
    true
  end
end
