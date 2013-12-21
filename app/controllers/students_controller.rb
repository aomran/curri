class StudentsController < ApplicationController

  skip_before_action :authorize
  before_action :check_if_logged_in, only: [:new]
  before_action :get_invitation, only: [:create, :enroll]

  def new
    @user = User.new
    @token = params[:token]
  end

  def create
    @user = User.new(user_params)
    @user.classrole = Student.create
    if @user.save
      claim_invitation
    else
      render :new
    end
  end

  def login
    @token = params[:token]
  end

  def enroll
    @user = User.find_by_email(params[:user][:email])

    if !@user.try(:student?)
      flash.now.alert = "You need a student account to accept the invitation."
      render :login
    else
      if @user.try(:authenticate, params[:user][:password])
        claim_invitation
      else
        flash.now.alert = "Email or password are not correct"
        render :login
      end
    end

  end

  private
  def get_invitation
    @token = params[:user][:token]
    @invitation = Invitation.find_by(token: @token)
    if @invitation.nil? || @invitation.student
      flash.now.alert = "The invitation is no longer valid or the URL is incorrect"
      action = params[:action] == 'create' ? :new : :login
      render action
    end
  end

  def claim_invitation
    session[:user_id] = @user.id
    @invitation.student = @user.classrole
    @invitation.save
    redirect_to classrooms_path
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

  def check_if_logged_in
    redirect_to students_login_path(params[:token]) if current_user.try(:student?)
  end
end