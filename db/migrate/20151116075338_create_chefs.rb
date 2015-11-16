class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.chefname
      t.email
      t.timestamps
    end
  end
end
