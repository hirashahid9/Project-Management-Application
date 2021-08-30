class ProjectPolicy < ApplicationPolicy

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
  end
 
  def create?
    return true if !user.nil? && user.manager? 
  end
 
  def update?
    return true if user && user.manager? && article.manager_id == user.id
  end
 
  def destroy?
    return true if user && user.manager? && article.manager_id == user.id
  end

  def addmember?
    return true if user && user.manager? && article.manager_id == user.id
  end
 
  private
 
    def article
      record
    end
end