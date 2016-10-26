class UsersController < ApplicationController
  def new
    @user = User.new
  end




  def create
    @user = User.new(user_params)
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    if @user.save
      #NamloMailer.account_activation(@user).deliver
      #SendEmailJob.send(wait: 30.seconds).perform_later(@contact)
      @user.send_activation_email
      login @user
      flash[:success]= "Please, check your email for instructions on how to activate your email "
      redirect_to root_path
      #redirect_to dashboard_index_path
      else
      render "new"
    end

    end

    private

    def user_params
      params.require(:user).permit(:first_name,:last_name, :email, :password, :password_confirmation)
    end

  end
