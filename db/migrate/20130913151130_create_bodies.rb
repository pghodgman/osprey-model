class CreateBodies < ActiveRecord::Migration
  def change
    create_table :bodies do |t|
      t.binary :data
      t.integer :kind
      t.integer :version

      t.timestamps
    end
  end
end
