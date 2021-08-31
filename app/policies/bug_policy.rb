class BugPolicy < ApplicationPolicy

  class Scope < ProjectPolicy
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      @scope.where(id: [@user.projects.ids])
    end
  end

  def index?
    projects = user.projects
    projects = projects.select(:id).pluck(:id)
    id = record.pluck(:id)
    return true if user.present? && projects.include?(id[0])
  end
 
  def create?
    return true if !user.nil? && user.qa? 
  end
 
  def update?
    return true if !user.nil? && user.qa? && article.creator_id == user.id
  end
 
  def destroy?
    return true if user && user.qa? && article.creator_id == user.id
  end

  def assignuser?
    return true if !user.nil? && user.developer? 
  end

  def resolveBug?
    return true if !user.nil? && user.developer? && article.developer_id == user.id 
  end
 
  private
    def article
      record
    end

end