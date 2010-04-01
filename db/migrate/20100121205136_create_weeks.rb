class CreateWeeks < ActiveRecord::Migration
  
  
       
  def self.up
    create_table :weeks do |t|
      t.integer :woy          #week of the year
      t.integer :year
      t.date :start_date
      t.boolean :init
      t.timestamps
    end
  end

  def self.down
    drop_table :weeks
  end
end
