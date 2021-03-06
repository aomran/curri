require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @blank_user = User.new
    @blank_user.invalid?
    @teacher = users(:teacher1)
    @student = users(:student1)
    @nameless_student = users(:nameless_student)
    @classroom = classrooms(:one)
    @invitation1 = invitations(:one)
  end

  test "email must not be empty" do
    assert @blank_user.errors[:email].any?
  end

  test "email must be formated correctly" do
    user = User.new(email: 'ahmed')
    user.valid?
    assert user.errors[:email].any?
  end

  test "student? method" do
    assert_equal true, @student.student?
    assert_equal false, @student.teacher?
  end

  test "teacher? method" do
    assert_equal false, @teacher.student?
    assert_equal true, @teacher.teacher?
  end

  test "naming validation" do
    # nameless student bad; nameless teacher ok
    @teacher.valid?
    assert_empty @teacher.errors[:first_name]
    @nameless_student.valid?
    assert @nameless_student.errors[:first_name].any?
  end
end
