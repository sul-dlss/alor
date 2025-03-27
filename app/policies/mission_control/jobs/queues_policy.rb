# frozen_string_literal: true

module MissionControl
  module Jobs
    # Policy for managing mission control access to queues in the application
    class QueuesPolicy < ActionPolicy::Base
      alias_rule :show?, :index?, to: :manage?

      def manage?
        true
        #   ::Current.groups.include?(
        #     Settings.authorization_workgroup_names.administrators
        #   )
      end
    end
  end
end
