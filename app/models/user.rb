class User < ActiveRecord::Base
  belongs_to :classrole, polymorphic: true
  validates  :email, presence: true
  validates :email, uniqueness: true

  has_secure_password

  delegate :classrooms, to: :classrole

end