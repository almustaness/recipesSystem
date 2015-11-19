class Chef < ActiveRecord::Base
  #In this line we create a relationship one-to-many between Chefs & Recipes
  #Chef in a single object which has plural objects. So "recipes" is written in plural. Let us see how it is written in Recipe Model
  has_many :recipes
  #This statment is used to make email downcase before it is stored in the database
  before_save {self.email = email.downcase}
  #We use reqular expression to check email format posted by the user. So we will store this regular expression in a variable and then we call that variable 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :chefname, presence: true, length: {minimum:3, maximum:40}
  #check uniqueness and do not check email case-sensitivity. If we write (uniqueness:true) , we may get error
  validates :email, presence: true, uniqueness: {case_sensitive:false},
  #Here we call the variable which tests email format
  format: {with: VALID_EMAIL_REGEX}
end
