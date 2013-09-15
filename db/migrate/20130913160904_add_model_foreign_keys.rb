class AddModelForeignKeys < ActiveRecord::Migration
  def change
    add_column :bodies,  "model_id", :integer
    add_column :bodies,  "transform_id", :integer
  end
end
