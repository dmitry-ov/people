class CreateRespondLogs < ActiveRecord::Migration
  def change
    create_table :respond_logs do |t|
      t.date :responddate
      t.integer :region_id
      t.string :status
      t.text :message

      t.timestamps
    end
  end
end
