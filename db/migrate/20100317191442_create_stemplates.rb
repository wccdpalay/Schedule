class CreateStemplates < ActiveRecord::Migration
  
  def self.up
    create_table :stemplates do |t|
      t.integer  "dtemplate_id"
      t.integer  "start_time"
      t.integer  "user_id"
      t.string   "spot"
      t.timestamps
    end
  end

  def self.down
    drop_table :stemplates
  end
end
