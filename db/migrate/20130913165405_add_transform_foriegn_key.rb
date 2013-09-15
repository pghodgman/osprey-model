class AddTransformForiegnKey < ActiveRecord::Migration
  def change
    remove_column :bodies,  "transform_id", :integer
    add_column :transforms,  "body_id", :integer
  end
end
