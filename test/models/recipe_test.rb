
#We have to write this line in every test.
require 'test_helper'
#For testing, the class is written
class RecipeTest < ActiveSupport::TestCase
  #We need to set up the values to test them
  def setup
    #This should not be local variable. We we should make it available to tests
    @chef = Chef.create(chefname:"bob",email:"bob@example.com")
    #As we have an associations between Chefs & Recipes, here we let the recipe to be assigned with Chef-ID
    #Even we used create method here, this record just goes to the Sand Box. It will not be stored in the Database
    @recipe = @chef.recipes.create(name: "Chicken meal", summary: "This is the summary of this recipe that you should follow",
    description: "This is the description of this recipe that descripes it")
  end


  #We should declare the a test for somthing like so
  test "Recipe should be valid" do
    assert @recipe.valid?
  end
  test "chef_id must present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  test "Name should present" do
    @recipe.name = " "
    assert_not @recipe.valid? 
  end
  
  test "Summary should not be too long" do
   @recipe.summary = "a" * 100
   #assert_not makes the validation wrong. See here the summary's length matches our validation but still we get failure
   #Here we included the message which will appear if the validation is wrongong
   assert_not @recipe.valid?, "Ops why you write too long summary. Shorten it please"
  end
  
  test "Summary should not be too short" do
    @recipe.summary = "abcdabcdabcdabcd"
    assert @recipe.valid?
  end
  
  test "Summary should be present" do 
    @recipe.summary = " "
    #also see here we are inserting empty summary but it does not give us an error
    assert @recipe.valid? 
  end
  
  test "Description should not be too long" do
    @recipe.description = "a" * 405
    assert @recipe.valid?
  end
  
  test "Description should not be too short" do
    @recipe.description = "a" * 21
    assert @recipe.valid?
  end
  
  test "Description should be present" do 
     @recipe.description = "G" * 20
    assert @recipe.valid?
  end
  
end