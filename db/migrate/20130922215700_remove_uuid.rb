class RemoveUuid < ActiveRecord::Migration
  def change
    remove_column :levels, :uuid
  end
end
