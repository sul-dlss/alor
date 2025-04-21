# frozen_string_literal: true

module MissionControl
  module Jobs
    # Policy for managing mission control access to queues in the application
    class QueuesPolicy < ApplicationPolicy
      # @note These two rule macros effectively forward all rules to #manage?
      # @see https://actionpolicy.evilmartians.io/#/aliases?id=default-rule
      default_rule :manage?
      alias_rule :index?, :create?, :new?, to: :manage?

      def manage?
        admin?
      end
    end
  end
end
