class AddRegionIdToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :region_id, :integer
  end
end
