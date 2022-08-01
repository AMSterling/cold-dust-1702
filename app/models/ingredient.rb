class Ingredient <ApplicationRecord
  validates_presence_of :name, :calories
  validates_numericality_of :calories
  has_many :dish_ingredients
  has_many :dishes, through: :dish_ingredients
end
