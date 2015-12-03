class Like < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  
  #We want the user to LIKE/DISLIKE once for each recipe. This is the validation. If we do not add "SCOPE" for each recipe, then the Chef will only be allowed to be recorded in LIKE TABLE once. which means he will be able only to LIKE/DISLIKE one recipe.
  validates_uniqueness_of :chef, scope: :recipe
end