class AnalyticsController < ApplicationController

  before_action :authorize
  before_action :authorize_teacher
  before_action :get_nested_classroom

  def show
    @track = @classroom.tracks.find(params[:track_id])

    # @start_at = 0
    # @end_at = 0
    @phase = Phase.new(@track,"default")
    #@start_time = phase.start_time
    #@end_time = phase.end_time

  end

  # def scope
  #   @tracks = @classroom.tracks
  #   now = Time.zone.now
  #   @start_at = params[:start_at].to_i
  #   @end_at = params[:end_at].to_i

  #   @start_time = now - @start_at*60
  #   @end_time = now - @end_at*60

  #   render :index
  # end
end
