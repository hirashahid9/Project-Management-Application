class Bug < ApplicationRecord
  belongs_to :project
  validates :title, presence: true, uniqueness: { scope: :project_id,  message: "with this title already exists in the project" }
end
