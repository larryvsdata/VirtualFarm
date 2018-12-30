class SessionsController < ApplicationController

  def sign_in
  end

  def log_in
    #binding.pry
    owner= Owner.find_by(name: params[:owner][:name])
    if owner.authenticate(params[:owner][:password])

      session[:owner_id] = owner.id
      redirect_to owner_path(owner)
    else
      redirect_to sign_in_path
    end
  end

  def sign_out
    session.clear
    redirect_to signin_path
  end
end
