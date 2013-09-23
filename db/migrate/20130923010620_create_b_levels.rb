class CreateBLevels < ActiveRecord::Migration
  def change
    create_table :b_levels do |t|
      t.string :name
      t.binary :uuid

      t.timestamps
    end
  end
end
