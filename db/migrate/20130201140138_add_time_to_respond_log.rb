class AddTimeToRespondLog < ActiveRecord::Migration
  def change
    add_column :respond_logs, :time, :float
  end
end
