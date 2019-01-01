class SessionsController < ApplicationController

  def sign_in
    @owner = Owner.new
  end

  def log_in
    #binding.pry
    @owner= Owner.find_by(name: params[:owner][:name])
    if @owner && @owner.authenticate(params[:owner][:password])

      session[:owner_id] = @owner.id
      redirect_to owner_path(@owner)
    else
      flash[:alert] = "Wrong Combination"
      render signin_path
    end
  end

  def sign_out
    session.clear
    redirect_to signin_path
  end
end
