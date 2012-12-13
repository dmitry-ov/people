class CreateRespondLogs < ActiveRecord::Migration
  def change
    create_table :respond_logs do |t|
      t.date :responddate
      t.integer :region_id
      t.text :status

      t.timestamps
    end
  end
end
