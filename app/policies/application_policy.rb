# frozen_string_literal: true

# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  pre_check :allow_admins
  alias_rule :manage?, to: :allow_admins

  def allow_admins
    allow! if admin?
  end

  private

  def admin?
    Current.groups.include?(Settings.authorization_workgroup_names.administrators) ||
      Current.groups.include?(Settings.authorization_workgroup_names.collection_creators)
  end
end
