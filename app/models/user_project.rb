class UserProject < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :project, uniqueness: { scope: [:user] }
end
