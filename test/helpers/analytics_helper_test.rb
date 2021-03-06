require 'test_helper'

class AnalyticsHelperTest < ActionView::TestCase

  before do
    # checkpoints(:one) has two unique ratings (score of 1)
    @checkpoint = checkpoints(:one)
    @total_count = checkpoints(:one).track.classroom.students.length
    @total_count_noratings = checkpoints(:noratings).track.classroom.students.length

    # stubbing time
    date_in_future = Time.zone.now + 1
    Time.zone.expects(:now).returns(date_in_future)

    @phase = Phase.new(@checkpoint.track,"Realtime")
  end

  test "checkpoint with two ratings count" do
    ratingData = @phase.ratings(@checkpoint)
    assert_equal({ :count => 0, :percent => 0.0, score: 0 }, ratings_count(ratingData, @total_count, 0))
    assert_equal({ :count => 2, :percent => 100.0, score: 1 }, ratings_count(ratingData, @total_count, 1))
    assert_equal({ :count => 0, :percent => 0.0, score: 2 }, ratings_count(ratingData, @total_count, 2))
  end

  test "checkpoint with one rating count" do
    total_count = checkpoints(:onerating).track.classroom.students.length
    ratingData = @phase.ratings(checkpoints(:onerating))

    assert_equal({ :count => 0, :percent => 0.0, score: 0 }, ratings_count(ratingData, total_count, 0))
    assert_equal({ :count => 1, :percent => 50.0, score: 1 }, ratings_count(ratingData, total_count, 1))
    assert_equal({ :count => 0, :percent => 0.0, score: 2 }, ratings_count(ratingData, total_count, 2))
  end

  test "checkpoint without ratings count" do
    ratingData = @phase.ratings(checkpoints(:noratings))
    assert_equal({ :count => 0, :percent => 0.0, score: 0 }, ratings_count(ratingData, @total_count_noratings, 0))
    assert_equal({ :count => 0, :percent => 0.0, score: 1 }, ratings_count(ratingData, @total_count_noratings, 1))
    assert_equal({ :count => 0, :percent => 0.0, score: 2 }, ratings_count(ratingData, @total_count_noratings, 2))
  end

  test "only one rating per student counts" do
    Rating.create(score: 1, student: students(:student1), checkpoint: checkpoints(:noratings))
    Rating.create(score: 2, student: students(:student1), checkpoint: checkpoints(:noratings))

    ratingData = @phase.ratings(checkpoints(:noratings))
    assert_equal({ :count => 0, :percent => 0.0, score: 1 }, ratings_count(ratingData, @total_count_noratings, 1))
    assert_equal({ :count => 1, :percent => 50.0, score: 2 }, ratings_count(ratingData, @total_count_noratings, 2))
  end

  test "empty bar ratings count" do
    ratingData = @phase.ratings(checkpoints(:noratings))
    assert_equal({ :count => 2, :percent => 100.0, score: 3 } , no_ratings(ratingData, @total_count_noratings))

    ratingData = @phase.ratings(@checkpoint)
    assert_equal({ :count => 0, :percent => 0.0, score: 3 } , no_ratings(ratingData, @total_count))
  end

  test "build bars" do
    ratings = @phase.ratings(@checkpoint)
    progress_bar =
      content_tag :div, class: "progress-bar", style: 'width: 100.0%' do
        concat(content_tag :div, '', class: 'progress-bar-warning')
        concat(content_tag :div, '100%', class: 'progress-bar-label')
      end
    assert_equal progress_bar, render_bar(ratings_count(ratings, @total_count, 1))
  end

  test "build bars with scores" do
    ratings = @phase.ratings(@checkpoint)
    progress_bar =
      content_tag :div, class: "progress-bar", style: 'width: 100.0%' do
        concat(content_tag :div, '', class: 'progress-bar-warning')
        concat(content_tag :div, '2', class: 'progress-bar-label')
      end
    assert_equal progress_bar, render_bar(ratings_count(ratings, @total_count, 1), true)
  end
end
