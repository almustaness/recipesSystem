
#Model file's name should be singular and lowercase. The class in singular but Uppercase.
#here we write our validation for Recipe table.
class Recipe < ActiveRecord::Base
    #In this line we create a relationship one-to-many between Recipes & Chefs
    #Recipe is a single object which belongs to a single object (Chef). So "chef" is written as singular. Let us see how it is written in Chef Model
    belongs_to :chef
    #We want all ASSOCIATED LIKES to a recipe to be deleted once we delete that recipe. So we use :DEPANDANT to do that
    has_many :likes, dependent: :destroy
    #This is realted to MANY-TO-MANY Relationship
    has_many :recipe_styles , dependent: :destroy
    #Here we create many to many relationship using JOIN table called RECIPE_STYLES
    has_many :styles, through: :recipe_styles
    #This is realted to MANY-TO-MANY Relationship
    has_many :recipe_ingredients , dependent: :destroy
    #Here we create many to many relationship using JOIN table called RECIPE_INGREDIENTS
    has_many :ingredients, through: :recipe_ingredients
    # Recipe's name must be inserted and its length should be between 5 and 105
    validates :name, presence: true, length: {minimum:5, maximum: 105}
    validates :summary, presence: true, length: {minimum:10, maximum: 150}
    validates :description, presence: true, length: {minimum:20, maximum: 500}
    #This is for recipes image. "PICTURE-UPLOADER" should be camel case, rails' convention
    mount_uploader :picture, PictureUploader
    #We'll use a method to validate the picture size in the sever-side
    validate :picture_size
    
    #Here we want to calculate thumbs up using this method. Also you can calculate anything using "WHERE" and the "FIELD NAME with VALUE"
    def thumbs_up_total
      # "SELF" is the passed "@RECIPE"
      self.likes.where(like: true).size
    end
     #Here we want to calculate thumbs down using this method
    def thumbs_down_total
      self.likes.where(like: false).size
    end
    
    #By default we want all recipes to be ordered by LAST UPDATE TIME. So we need to define a DEFAULT SCOPE
    # We'll specify descendant order ":DESC"
    default_scope -> {order(updated_at: :desc)}
    
    #And here is the definition of this method for picture size
    private
     def picture_size
         if picture.size > 5.megabytes
             errors.add(:picture, "should be less than 5MB")
         end
     end
     
end

