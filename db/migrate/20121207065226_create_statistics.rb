class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.date :date

      t.timestamps
    end
  end
end
