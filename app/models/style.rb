class Style < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2, maximum: 25 }
  #This is realted to MANY-TO-MANY Relationship
  has_many :recipe_styles
  #Here we create many to many relationship using JOIN table called RECIPE_STYLES
  has_many :recipes, through: :recipe_styles
end