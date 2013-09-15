class CreateTransforms < ActiveRecord::Migration
  def change
    create_table :transforms do |t|
      t.float :x
      t.float :y
      t.float :z
      t.float :xrot
      t.float :yrot
      t.float :zrot
      t.float :wrot
      t.float :xscale
      t.float :yscale
      t.float :zscale

      t.timestamps
    end
  end
end
