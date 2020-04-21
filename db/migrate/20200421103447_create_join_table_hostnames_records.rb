class CreateJoinTableHostnamesRecords < ActiveRecord::Migration[5.2]
  def change
    create_join_table :hostnames, :records do |t|
      t.index [:hostname_id, :record_id]
      t.index [:record_id, :hostname_id]
    end
  end
end
