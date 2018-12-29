class Owner < ApplicationRecord
  has_secure_password
  has_many :owner_farms
  has_many :farms , through: :owner_farms
  has_many :animals , through: :farms

  validates :name , presence: true
  validates :name , uniqueness: true
  validates :password_digest , presence: true
  validates :password_digest , length: {minimum: 4}
  validates :money , presence: true
  validates :money , numericality: {more_than_or_equal_to: 0}

  def buy_farm(a_farm)
    if self.money >= a_farm.get_value
      self.farms << a_farm
      self.pay(a_farm.get_value)
      a_farm.available = false
      a_farm.save
      return "Successfully bought #{a_farm.name}"
    else
      return "Insufficient money."
    end
  end

  def sell_farm(a_farm)
    self.get_paid(a_farm.get_value)
    a_farm.available = true
    a_farm.save
    self.farms.delete(a_farm)
    return "Sold #{a_farm.name}"
  end

  def pay(amount)
    self.money -= amount
  end

  def get_paid(amount)
    self.money += amount
  end


end
