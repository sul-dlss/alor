module MissionControl
  module Jobs
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
