class RemoveStringUuid < ActiveRecord::Migration
  def change
    def change
      remove_column :levels,  "uuid", :string
    end
  end
end
