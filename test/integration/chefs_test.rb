require 'test_helper'

class ChefsTest < ActionDispatch::IntegrationTest

  def setup
    @chef_one = Chef.create!(chefname: "Dave", email: "dave@dave.com", password: "password", password_confirmation: "password")
    @chef_two = Chef.create!(chefname: "Samantha", email: "sam@example.com", password: "password", password_confirmation: "password")
  end
  
  test "should get chefs index" do
    get chefs_url
    assert_response :success
  end
  
  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef_one), text: @chef_one.chefname
    assert_select "a[href=?]", chef_path(@chef_two), text: @chef_two.chefname
  end

  test "should delete chef" do
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef_two)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
  

end
