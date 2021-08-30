class User < ApplicationRecord

  belongs_to :role
  has_many :user_projects, dependent: :destroy
  has_many :projects, :through => :user_projects
  has_many :bugs

  #validates :name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 def manager?
  mID=Role.where(name: 'Manager').ids
  role_id == mID[0]
 end

 def developer?
  dID=Role.where(name: 'Developer').ids
  role_id == dID[0]
 end

 def qa?
  qID=Role.where(name: 'QA').ids
  role_id == qID[0]
 end

end
