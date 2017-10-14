require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: 'Dave', email: 'dave@example.com')
    @recipe = Recipe.create!(name: "Vegetable Sautee", description: "Great vegetable sautee - add vegetable and oil", chef: @chef)
    @recipe_two = @chef.recipes.build(name: "Chicken Sautee", description: "Great chicken dish")
    @recipe_two.save
  end

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe_two.name, response.body
  end
  
  # test "the truth" do
  #   assert true
  # end
end
