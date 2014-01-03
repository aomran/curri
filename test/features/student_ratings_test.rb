require 'test_helper'

class StudentRatingsTest < Capybara::Rails::TestCase

  test "a student can rate checkpoints" do
    PrivatePub.stubs(:publish_to)

    student = users(:student1)
    login_as(student)

    click_link classrooms(:one).name
    click_link tracks(:one).name

    checkpoint = checkpoints(:one)
    assert page.has_content?(checkpoint.expectation)

    within "#checkpoint#{checkpoint.id}" do
      click_button 'Totally Understand'
    end

    assert find("#checkpoint#{checkpoint.id}").has_css?('.checkpoint_2')
  end

end