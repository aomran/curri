require 'test_helper'

class StudentAccountsTest < Capybara::Rails::TestCase

  test "a student can accept invitation and create an account" do
    teacher = users(:ahmed)
    student_email = 'mystudent@gmail.com'

    login_as(teacher)
    invite_student(teacher, student_email)

    invitation = Invitation.last

    visit claim_invitation_path(invitation.token)

    fill_in :user_email, with: 'student@gmail.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'

    assert_difference 'User.count' do
      click_button 'register-student'
    end

  end

  test "student with account can claim invitation without sign up" do
    teacher = users(:ahmed)
    student_email = 'mystudent@gmail.com'

    login_as(teacher)
    invite_student(teacher, student_email)

    within 'ul.nav' do
      click_link 'Logout'
    end
    assert_equal current_path, login_path

    invitation = Invitation.last

    visit claim_invitation_path(invitation.token)

    click_link 'skip this step'
    assert_equal current_path, login_invitation_path(invitation.token), 'Did not go to page where students can log in to claim invitation'

    fill_in :user_email, with: users(:student).email
    fill_in :user_password, with: 'password123'
    click_button 'Login & Claim'

    assert_equal users(:student).classrole, Invitation.last.student, 'Student was not added to the classroom'
  end

  test "logged in student can claim invitation" do
    skip
  end
end