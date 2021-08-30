class Project < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

	has_many :user_projects, dependent: :destroy
    has_many :users, :through => :user_projects
    belongs_to :manager, class_name: :User
    validates :title, presence: true, uniqueness: true
    has_many :bugs, dependent: :destroy
end
