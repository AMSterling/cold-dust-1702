require 'rails_helper'

RSpec.describe 'the dish show page' do
  it 'shows the dish name and description' do
    iuzzini = Chef.create!(name: 'Johnny Iuzzini')
    childs = Chef.create!(name: 'Julia Childs')
    flay = Chef.create!(name: 'Bobby Flay')

    caramel = Dish.create!(name: 'Caramel', description: 'Sweets that do not stick to your teeth', chef_id: iuzzini.id)
    chocolate = Dish.create!(name: 'Chocolate', description: 'Cocoa bean bar', chef_id: iuzzini.id)
    casserole = Dish.create!(name: 'Casserole', description: 'A dish that is difficult to clean up', chef_id: childs.id)
    salad = Dish.create!(name: 'Salad', description: 'Vegetarian delight right', chef_id: childs.id)
    spaghetti = Dish.create!(name: 'Spaghetti', description: 'Meat and noodles', chef_id: flay.id)
    steak = Dish.create!(name: 'Steak', description: 'Piece of cow ass', chef_id: flay.id)

    butter = Ingredient.create!(name: 'Butter', calories: 50)
    pasta = Ingredient.create!(name: 'Pasta', calories: 75)
    meat = Ingredient.create!(name: 'Meat', calories: 100)
    lettuce = Ingredient.create!(name: 'Lettuce', calories: 10)
    cocoa = Ingredient.create!(name: 'Cocoa', calories: 25)
    sugar = Ingredient.create!(name: 'Sugar', calories: 15)

    DishIngredient.create!(dish_id: caramel.id, ingredient_id: butter.id)
    DishIngredient.create!(dish_id: caramel.id, ingredient_id: sugar.id)

    DishIngredient.create!(dish_id: chocolate.id, ingredient_id: sugar.id)
    DishIngredient.create!(dish_id: chocolate.id, ingredient_id: cocoa.id)

    DishIngredient.create!(dish_id: casserole.id, ingredient_id: pasta.id)
    DishIngredient.create!(dish_id: casserole.id, ingredient_id: butter.id)

    DishIngredient.create!(dish_id: salad.id, ingredient_id: lettuce.id)

    DishIngredient.create!(dish_id: steak.id, ingredient_id: meat.id)
    DishIngredient.create!(dish_id: steak.id, ingredient_id: butter.id)

    DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: pasta.id)
    DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: meat.id)

    visit dish_path(caramel)

    expect(page).to have_content('Name: Caramel')
    expect(page).to have_content('Description: Sweets that do not stick to your teeth')
    expect(page).to_not have_content('Name: Casserole')

    within '#ingredients-0' do
      expect(page).to have_content('Ingredients: Butter')
    end

    within '#ingredients-1' do
      expect(page).to have_content('Ingredients: Sugar')
    end

    expect(page).to have_content('Chef: Johnny Iuzzini')
    expect(page).to have_content('Calories: 65')
  end
end
