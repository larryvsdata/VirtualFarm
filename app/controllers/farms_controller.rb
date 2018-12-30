class FarmsController < ApplicationController
before_action :set_farm , only: [:show ,:edit , :update]
skip_before_action :verify_authenticity_token
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

end
