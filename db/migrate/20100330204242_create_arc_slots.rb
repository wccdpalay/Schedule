class CreateArcSlots < ActiveRecord::Migration
  def self.up
    create_table :arc_slots do |t|
      t.integer :day_id
      t.integer :start_time
      t.integer :user_id
      t.string  :spot
      t.timestamps
    end
  end

  def self.down
    drop_table :arc_slots
  end
end
