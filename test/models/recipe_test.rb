require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Test", email: "test@example.com", password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.build(name: "Vegetable Soup", description: "Great soup recipe.")
  end
  
  test "Recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "Recipe should be valid" do
    @recipe.valid?
  end
  
  test "Name should be present" do
    @recipe.name = ""
    assert_not @recipe.valid?
  end
  
  test "Description should be present" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end
  
  test "Description shouldn't be less than five characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end

  test "Description shouldn't be more than five hundred characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end

end