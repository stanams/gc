class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
      )

    if @user
      sign_in(@user)
      redirect_to check_form_redemption_cards_url
    else
      flash.now[:errors] = ["Invalid email or password."]
      render :new
    end

  end

  def destroy
    current_user.reset_session_token! unless current_user.nil?
    session[:session_token] = nil
    @current_user = {id: nil, email: nil}
    redirect_to new_session_url
  end

end
