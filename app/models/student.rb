class Student < ActiveRecord::Base
  has_one :user, as: :classrole, dependent: :destroy
  has_many :invitations
  has_many :requesters
  has_many :classrooms, through: :invitations
  has_many :ratings

  delegate :email, to: :user
  delegate :first_name, to: :user
  delegate :last_name, to: :user
  delegate :full_name, to: :user
  delegate :gravatar, to: :user

  def ratings_by_track(track)
    ratings.where({ checkpoint_id: track.checkpoints.pluck(:id) }).distinct_by_checkpoint
  end

  def needs_help?(classroom)
    classroom.requesters.find_by(student_id: id).help
  end
end
