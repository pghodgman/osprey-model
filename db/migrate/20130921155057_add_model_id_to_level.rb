class AddModelIdToLevel < ActiveRecord::Migration
  def change
    add_column :levels,  "model_id", :integer
  end
end
