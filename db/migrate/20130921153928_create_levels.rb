class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :uuid
      t.float :elevation
      t.string :name

      t.timestamps
    end
  end
end
