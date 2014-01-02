require 'test_helper'

class TracksControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "get list of tracks" do
    get :index, classroom_id: classrooms(:one)
    assert assigns(:tracks)
    assert :success
  end

  test "show single track" do
    get :show, classroom_id: classrooms(:one), id: tracks(:one)
    assert assigns(:track)
    assert :success
  end

  test "get new track form" do
    get :new, classroom_id: classrooms(:one)
    assert assigns(:track)
    assert :success
  end

  test "should create track with valid data" do
    assert_difference 'Track.count' do
      post :create, classroom_id: classrooms(:one), track: {name: "Test Track", start_date: "2013-10-1", start_time: "6:30pm", end_date: "2013-10-1", end_time: "9:30pm"}
    end

    assert_redirected_to classroom_tracks_path(assigns(:classroom))
  end

  test "should not create track with invalid data" do
    post :create, classroom_id: classrooms(:one), track: {name: nil}
    assert_template :new
  end

  test "should correctly create time/date attributes" do
    post :create, classroom_id: classrooms(:one), track: {name: "Test Track", start_date: "2013-10-1", start_time: "6:30pm", end_date: "2013-10-1", end_time: "9:30pm"}

    assert_equal Time.zone.parse("2013-10-1 6:30pm"), Track.last.start_time
    assert_equal Time.zone.parse('2013-10-1 9:30pm'), Track.last.end_time
  end

  test "get edit track form" do
    get :edit, classroom_id: classrooms(:one), id: tracks(:one)
    assert_equal tracks(:one), assigns(:track)
    assert :success
  end

  test "should update track with valid data" do
    patch :update, classroom_id: classrooms(:one), id: tracks(:one), track: {name: "Changed name" }

    track = Track.find(tracks(:one))
    assert_equal "Changed name", track.name
    assert_redirected_to classroom_track_path(assigns(:classroom), assigns(:track))
  end

  test "should not update track with invalid data" do
    patch :update, classroom_id: classrooms(:one), id: tracks(:one), track: {name: nil }

    assert_template :edit
  end

  test "should correctly update time/date attributes" do
    patch :update, classroom_id: classrooms(:one), id: tracks(:one), track: {start_date: "2013-08-10", start_time: "6:30pm", end_date: "2013-08-10", end_time: "11:30pm"}

    assert_equal Time.zone.parse('2013-08-10 6:30pm'), tracks(:one).reload.start_time
    assert_equal Time.zone.parse('2013-08-10 11:30pm'), tracks(:one).reload.end_time
  end

  test "delete track" do
    assert_difference 'Track.count', -1 do
      delete :destroy, classroom_id: classrooms(:one), id: tracks(:one)
    end
    assert_redirected_to classroom_tracks_path(assigns(:classroom))
  end
end
