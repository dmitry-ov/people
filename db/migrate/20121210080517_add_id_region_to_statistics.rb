class AddIdRegionToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :id_region, :integer
  end
end
