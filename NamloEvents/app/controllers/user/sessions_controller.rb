class User::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def new
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      #redirect_to root_path
      #redirect_to dashboard_index_path
    else
      flash[:danger] = "Sorry, you probably entered invalid email or password. Please, try again"
      render "new"
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        #redirect_back_or user
        #redirect_to dashboard_index_path
      else
        message = "Account not activated"
        message += "Check your email for the activation instructions."
        flash[:warning] = message
        redirect_to root_url

      end
        else
          flash[:danger] = "Sorry, you probably entered invalid email or password. Please, try again"
          render "new"
      end

    end

    def destroy
      logout if sign_in?
      redirect_to root_path
    end


  end
