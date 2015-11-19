require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname:"Jone", email:"Jone@example.com")
  end
  
  test "Chef should be valid" do
    assert @chef.valid?
  end
  
  test "Chef should be present" do
     @chef.chefname = " "
     assert_not @chef.valid?
  end
  
  test "Chefname should not be too long" do
    @chef.chefname = "b" * 100
  end
  
  test "Chefname should not be to short" do
    @chef.chefname = "ff"
  end
  
  test "email should be present" do
    @chef.email = " "
    assert @chef.valid?
  end
  
   test "email should be within bounds" do
    @chef.email = "b" * 100 + "@example.com"
  end
  
  test "Email should be unique" do
    # dup_chef takes a duplicated info from the above @chef.email. Then we compare the original @chef.email with the duplicated one in the local variable(dup_chef).
    dup_chef = @chef.dup
    #we do not want to check email sensitivity. So we'll us upcase method
    dup_chef.email = @chef.email.upcase
    dup_chef.save
    assert dup_chef.valid?
  end
    test "email validation should accept valid addresses" do
      #Here we use %W method to create an array of emails to push them one by one for testing. These are just emails
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
    #We will use a lopp to test them one by one
    valid_addresses.each do |va|
      #assign this email to @chef and then send it for testing
      @chef.email = va
      #We will show a message for each unacceptable email and that will be by using Insepct method
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be invalid'
    end
  end
  
end
