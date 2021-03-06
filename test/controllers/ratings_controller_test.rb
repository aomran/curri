require 'test_helper'

class RatingsControllerTest < ActionController::TestCase

  before do
    cookies[:auth_token] = users(:student1).auth_token
    Pusher.stubs(:trigger)
  end

  test "should create ratings with html request" do
    assert_difference 'Rating.count' do
      post :create, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint_id: checkpoints(:one).id, value: 0
    end
    assert_redirected_to classroom_track_path(classrooms(:one), tracks(:one))
  end

  test "should create ratings with json request" do
    assert_difference 'Rating.count' do
      xhr :post, :create, format: :json, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint_id: checkpoints(:one).id, value: 0
    end

    response = JSON.parse(@response.body)
    assert_equal 0, response["current_score"]
    assert_equal checkpoints(:one).id, response["checkpoint_id"]
  end

  test "rating should be associated with logged-in student" do
    post :create, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint_id: checkpoints(:one).id, value: 0
    assert_equal users(:student1).classrole, Rating.last.student
  end

  test "should publish data to push server" do
    Pusher.expects(:trigger).once
    post :create, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint_id: checkpoints(:one).id, value: 0
  end

  test "only students should be able to rate checkpoints" do
    cookies[:auth_token] = users(:teacher1).auth_token
    post :create, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint_id: checkpoints(:one).id, value: 0

    assert_redirected_to classroom_track_path(classrooms(:one), tracks(:one))
    assert_equal "Only students can rate", flash[:alert]
  end

end
