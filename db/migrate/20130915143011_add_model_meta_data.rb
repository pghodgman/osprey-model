class AddModelMetaData < ActiveRecord::Migration
  def change
    add_column :models, 'buildable_area', :float
    add_column :models, 'area_of_site', :float
    add_column :models, 'gross_area', :float
  end
end
