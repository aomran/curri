class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings

  validates :expectation, :success_criteria, presence: true
  validates_length_of :expectation, :maximum => 50
  validates_length_of :success_criteria, :maximum => 200

  default_scope { order(id: :asc) }

  def latest_student_score(student)
    ratings.where(student_id: student.id).last.try(:score)
  end

  def hasnt_voted(phase, classroom)
    scoped_ratings = phase.ratings(self)
    return ["all"] if scoped_ratings.empty?

    if classroom.students.size != scoped_ratings.length
      student_list = classroom.students.pluck(:id)
      scoped_ratings.includes(:student).each do |rating|
        student_list.delete(rating.student.id)
      end
      student_list.map { |id| Student.find(id).email }
    else
      []
    end
  end

end
