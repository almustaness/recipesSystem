#We create a new migration to add a column to a table. In this migration we get "Chane method" which we use to add our changes
#We need a migration for each change because we can run it one time unless we remove our schema or we roll back to an old version of migration
class AddChefIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :chef_id, :integerrake
  end
end
