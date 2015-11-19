
#Model file's name should be singular and lowercase. The class in singular but Uppercase.
#here we write our validation for Recipe table.
class Recipe < ActiveRecord::Base
    #In this line we create a relationship one-to-many between Recipes & Chefs
    #Recipe is a single object which belongs to a single object (Chef). So "chef" is written as singular. Let us see how it is written in Chef Model
    belongs_to :chef
    # Recipe's name must be inserted and its length should be between 5 and 105
    validates :name, presence: true, length: {minimum:5, maximum: 105}
    validates :summary, presence: true, length: {minimum:10, maximum: 150}
    validates :description, presence: true, length: {minimum:20, maximum: 500}
end

