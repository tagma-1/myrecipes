require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: 'Dave', email: 'dave@example.com', password: "password", password_confirmation: "password")
    @recipe = Recipe.create!(name: "Vegetable sautee", description: "Great vegetable sautee - add vegetable and oil", chef: @chef)
  end

  test "reject invalid recipe update" do
    sign_in_as(@chef, 'password')
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: {name: " ", description: "Some description"} }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "successfully edit a recipe" do
    sign_in_as(@chef, 'password')
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "Updated recipe name"
    updated_description = "Updated recipe description"
    patch recipe_path(@recipe), params: { recipe: {name: updated_name, description: updated_description }}
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match @recipe.name, updated_name
    assert_match @recipe.description, updated_description
  end
  
  # test "the truth" do
  #   assert true
  # end
end
