class IndexStatisticsHashvalues < ActiveRecord::Migration
  def up
    execute "CREATE INDEX statistics_hashvalues ON statistics USING GIN(hashvalue)"
  end

  def down
    execute "DROP INDEX statistics_hashvalues"
  end
end
