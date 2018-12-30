class FarmsController < ApplicationController
before_action :set_farm , only: [:show ,:edit , :update]
before_action :only_admin , only: [:new ,:create, :edit , :update]
skip_before_action :verify_authenticity_token


  def new
    @farm =Farm.new
  end

  def create
    #binding.pry
    @farm = Farm.new(farm_params)

    if @farm.save
      flash[:alert] = "Farm #{@farm.name} created, successfully."
      redirect_to farm_path(@farm)
    else
      flash[:alert] = "Failed to create farm."
      redirect_to new_farm_path
    end

  end

  def edit

  end

  def update

    if @farm.update(farm_params)
      flash[:alert] = "Farm #{@farm.name} updated, successfully."
      redirect_to farm_path(@farm)
    else
      flash[:alert] = "Failed to update the farm #{@farm.name}."
      redirect_to edit_farm_path
    end
  end


  def show

  end

  def index
    @available_farms = Farm.get_available_farms
    @owner = current_owner if is_signed_in?
    #binding.pry
  end

  def buy_farm
    owner = current_owner
    farm = Farm.find_by_id(params[:farm_id])
    message= owner.buy_farm(farm)
    flash[:alert]=message
  #  binding.pry
    owner.save
    redirect_to owner_path(owner.id)
  end


  def sell_farm
    owner = current_owner
    farm = Farm.find_by_id(params[:farm_id])
    message= owner.sell_farm(farm)
    owner.save
    flash[:alert]=message
  #  binding.pry
    redirect_to root_path
  end

  private
  def set_farm
    @farm = Farm.find(params[:id])
  end

  def farm_params
    params.require(:farm).permit(:name  )
  end

  def only_admin
    if !is_signed_in? || !current_owner.admin
      flash[:alert] = "You must be signed in as an administrator to browse this page."
      redirect_to root_path
    end
  end

end
