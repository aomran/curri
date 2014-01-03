class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings

  validates  :expectation, :success_criteria, presence: true

  default_scope { order(id: :asc) }

  def latest_student_score(student)
    ratings.where(student_id: student.id).last.try(:score)
  end

  def hasnt_voted(phase)
    scoped_ratings = phase.ratings(self)
    return ["all"] if scoped_ratings.empty?
    classroom = track.classroom

    if classroom.students.size != scoped_ratings.length
      student_list = classroom.students.pluck(:id)
      scoped_ratings.each do |rating|
        student_list.delete(rating.student.id)
      end
      student_list.map { |id| Student.find(id).email }
    else
      []
    end
  end

end
