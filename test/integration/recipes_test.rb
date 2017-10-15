require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: 'Dave', email: 'dave@example.com')
    @recipe = Recipe.create!(name: "Vegetable sautee", description: "Great vegetable sautee - add vegetable and oil", chef: @chef)
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
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe_two), text: @recipe_two.name
  end
  
  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end
  
  test "create new valid recipe" do
    get new_recipe_path
  end
  
  test "reject invalid recipe submissions" do
    get new_recipe_path
  end
  
  # test "the truth" do
  #   assert true
  # end
end
