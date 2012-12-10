class AddHashvalueToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :hashvalue, :hstore
  end
end
