class Bug < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
    
  belongs_to :project
  belongs_to :creator, class_name: :User
  belongs_to :developer, class_name: :User, optional: true

  validates :title, presence: true
  validates :types, presence:true
  validates :status, presence:true
  validates :title, uniqueness: { scope: :project_id,  message: "with this title already exists in the project" }
  mount_uploader :image, ImageUploader

end
