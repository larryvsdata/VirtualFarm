class FarmsController < ApplicationController
before_action :set_farm , only: [:show ,:edit , :update]

  def show

  end


  private
  def set_farm
    @farm = Farm.find(params[:id])
  end

  def farm_params
    params.require(:farm).permit(:name  )
  end

end
