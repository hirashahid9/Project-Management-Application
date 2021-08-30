class Bug < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :project
  validates :title, presence: true, uniqueness: { scope: :project_id,  message: "with this title already exists in the project" }
end
