# frozen_string_literal: true

# Channel policy for managing channel access and actions
class ChannelPolicy < ApplicationPolicy
  def new?
    admin?
  end

  def create?
    admin?
  end

end
