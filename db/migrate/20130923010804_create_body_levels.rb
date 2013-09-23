class CreateBodyLevels < ActiveRecord::Migration
  def change
    create_table :body_levels do |t|
      t.string :name
      t.binary :uuid

      t.timestamps
    end
  end
end
