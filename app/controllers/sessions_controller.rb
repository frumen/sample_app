class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      #redirect_back_or user --antes te llevaba a la pag de perfil del usuario 
      redirect_to root_path
    else
      flash.now[:error] = 'Pifiaste! Pone las cosas bien, pedazo de pastrami!'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
