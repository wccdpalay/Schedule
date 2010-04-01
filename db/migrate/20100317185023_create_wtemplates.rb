class CreateWtemplates < ActiveRecord::Migration
  
  def self.up
    create_table :wtemplates do |t|
      t.string :name
      t.timestamps
      t.integer :sat
      t.integer :sun
      t.integer :mon
      t.integer :tue
      t.integer :wed
      t.integer :thu
      t.integer :fri
      
    end
  end

  def self.down
    drop_table :wtemplates
  end
end
