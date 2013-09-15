class AddPreviewToModel < ActiveRecord::Migration
  def change
    add_column :models, "preview", :binary
  end
end
