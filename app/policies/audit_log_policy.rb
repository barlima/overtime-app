class AuditLogPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def confirm?
    user.id == record.user_id
  end

  private

  def admin?
    admin_types.include?(user.type)
  end
end
