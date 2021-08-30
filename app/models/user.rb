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
  role_id == 1
 end

 def developer?
  role_id == 2
 end

 def qa?
  role_id == 3
 end

end
