class AddUuidBinary < ActiveRecord::Migration
  def change
    add_column :levels, :uuid, :binary
  end
end
