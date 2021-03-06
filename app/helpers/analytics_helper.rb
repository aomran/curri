module AnalyticsHelper

  SCORE_WORD = ['danger', 'warning', 'success', 'empty']

  def ratings_count(ratings, total_count, score)
    count = 0
    if ratings.any?
      ratings.each do |rating|
        count += 1 if rating.score == score
      end
    end
    percent = calc_percent(count, total_count)
    { count: count, percent: percent, score: score }
  end

  def no_ratings(ratings, total_count)
    count = total_count - ratings.length
    percent = calc_percent(count, total_count)
    { count: count, percent: percent, score: 3 }
  end

  def calc_percent(count, total_count)
    total_count == 0 ? 0 : (count * 100.0 / total_count)
  end

  def render_bar(counts, show_count=false)
    percent = counts[:count] == 0 ? '' : "#{counts[:percent].round}%"
    content = show_count ? counts[:count] : percent
    content_tag :div, class: "progress-bar", style: "width: #{counts[:percent]}%" do
      concat(content_tag :div, '', class: "progress-bar-#{SCORE_WORD[counts[:score]]}")
      concat(content_tag :div, content, class: 'progress-bar-label')
    end
  end

  def ratings_count_box(checkpoint)
    count_num = @phase.ratings(checkpoint).length
    big_number = content_tag :div, count_num, class: 'count-number'
    byline = content_tag :p, 'response'.pluralize(count_num)
    big_number + byline
  end

  def hasnt_voted_box(hasnt_voted)
    content_tag :div, class: 'hasnt-voted' do
      concat(content_tag :h6, "Students that haven't voted:")
      concat(content_tag(:span, hasnt_voted.join(', ') + '.', class: 'student-not-voted'))
      concat(content_tag :div, "Note: Student list only shows when less than 25% of class hasn't voted", class: 'hasnt-voted-note')
    end
  end

end
