class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.integer :id_vk

      t.timestamps
    end
  end
end
