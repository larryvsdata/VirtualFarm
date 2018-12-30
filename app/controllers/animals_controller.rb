class AnimalsController < ApplicationController
  before_action :only_admin , only: [:create ,:edit , :update]
  before_action :set_animal , only: [:show]

  def create
    @farm = Farm.find_by(id: params[:animal][:farm_id])
    @farm.animals.build(animal_params)

    if @farm.save
      flash[:alert] = "Successfully created #{@farm.animals.last.name} in #{@farm.name} "
      redirect_to farm_animal_path(@farm ,  @farm.animals.last)
    else
      flash[:alert] = "Failed to create the animal in #{@farm.name} "
      redirect_to new_farm_animal_path
    end

    def show
    #  binding.pry
      if params[:farm_id]
        binding.pry
        @farm = Farm.find_by(id: params[:farm_id])
        redirect_to farm_animal_path(@farm , @animal)
      end
    end


  end


  private

  def only_admin
    if !is_signed_in? || !current_owner.admin
      flash[:alert] = "You must be signed in as an administrator to browse this page."
      redirect_to root_path
    end
  end

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:name , :unit_price  , :quantity )
  end

end
