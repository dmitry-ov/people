class AddHashvalueToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :hash, :hstore
  end
end
