class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.binary :image
      t.float :latitude
      t.float :longitude
      t.float :latspan
      t.float :longspan

      t.timestamps
    end
  end
end
