require 'test_helper'

class TeacherClassroomsTest < Capybara::Rails::TestCase

  before do
    teacher = users(:teacher1)
    login_as(teacher)
    @classroom = classrooms(:one)
  end

  test "a teacher can add a classroom" do
    click_link "Add Classroom"

    fill_in :classroom_name, with: "New classroom name"
    click_button 'Create Classroom'

    assert page.has_content?('New classroom name')
  end

  test "a teacher should see a list of their classrooms after login" do
    assert page.has_content?(@classroom.name)

    other_teachers_classroom = users(:teacher2).classrooms.first.name
    assert !page.has_content?(other_teachers_classroom), "Another teacher's classroom is listed"
  end

  test "a teacher can edit classrooms" do
    click_link @classroom.name

    click_link 'manage-classroom'

    assert_equal edit_classroom_path(@classroom), current_path

    fill_in :classroom_name, with: 'Changed classroom name'
    click_button 'Update Classroom'

    assert page.has_content?('Changed classroom name')
  end

  test "a teacher can delete classrooms" do
    click_link @classroom.name

    click_link 'manage-classroom'
    click_link 'delete-classroom'

    assert !page.has_content?(@classroom.name)
  end

  test "a teacher can join a classroom using token" do
    click_link "Join Classroom"

    fill_in :teacher_token, with: "ELtCtf7o"
    click_button 'Join Classroom'

    assert page.has_content?('New Classroom with token')
  end
end