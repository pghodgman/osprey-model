class AddForeignKeyToLocation < ActiveRecord::Migration
  def change
    add_column :locations,  "model_id", :integer
  end
end
