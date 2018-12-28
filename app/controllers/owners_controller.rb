class OwnersController < ApplicationController
  before_action :set_owner , only: [:show ,:edit , :update]

  def new
    @owner = Owner.new
  end

  def create
    #binding.pry
    @owner=Owner.new(owner_params)

    if @owner.save
    #  binding.pry
      session[:owner_id] = @owner.id
      flash[:notice] = "Welcome to Virtual Park!"
      redirect_to owner_path(@owner)
    else
      flash[:notice] = "Unable to log in."
      redirect_to new_owner_path
    end

  end



  private
  def set_owner
    @owner = Owner.find(params[:id])
  end

  def owner_params
    params.require(:owner).permit(:name , :password  , :money )
  end
end
