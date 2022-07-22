class CreateErrorCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :error_counters do |t|
      t.string :merchant
      t.string :reason
      t.integer :count
    end
  end
end
