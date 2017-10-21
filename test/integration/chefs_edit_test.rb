require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: 'Dave', email: 'dave@example.com', password: "password", password_confirmation: "password")
    @recipe = Recipe.create!(name: "Vegetable sautee", description: "Great vegetable sautee - add vegetable and oil", chef: @chef)
  end
  
    test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "dave@example.com"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Dave1", email: "dave1@example.com"} }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Dave1", @chef.chefname
    assert_match "dave1@example.com", @chef.email
  end
  
end
