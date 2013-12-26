module TracksHelper

  def nice_time_format(track, method)
    track.send(method).strftime("%l:%M%P") if track.send(method)
  end

  def nice_date_format(track, method)
    track.send(method).strftime("%Y-%m-%d") if track.send(method)
  end

  def display_start_end_times(track)
    if track.phasing?
      start_string = track.start_time.strftime("%l:%M%P, %e %b %y")
      end_string = track.end_time.strftime("%l:%M%P, %e %b %y")
      "Track start/end: #{start_string} to #{end_string}"
    end
  end
end
