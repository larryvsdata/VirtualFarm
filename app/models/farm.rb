class Farm < ApplicationRecord
  has_many :animals
  has_many :owner_farms
  has_many :owners , through: :owner_farms


  validates :name , presence: true

  def get_value
    value= 0
    self.animals.each do |animal|
      value+=animal.get_price
    end
    value
  end

  def self.get_available_farms
    where(available: true)
  end

end
