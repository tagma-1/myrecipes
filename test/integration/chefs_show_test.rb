require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: 'Dave', email: 'dave@example.com', password: "password", password_confirmation: "password")
    @recipe = Recipe.create!(name: "Vegetable sautee", description: "Great vegetable sautee - add vegetable and oil", chef: @chef)
    @recipe_two = @chef.recipes.build(name: "Chicken Sautee", description: "Great chicken dish")
    @recipe_two.save
  end
  
  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe_two), text: @recipe_two.name
    assert_match @recipe.description, response.body
    assert_match @recipe_two.description, response.body
    assert_match @chef.chefname, response.body
  end
end
