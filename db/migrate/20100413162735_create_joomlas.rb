class CreateJoomlas < ActiveRecord::Migration
  def self.up
    create_table :joomlas do |t|
      t.string :info
      t.timestamps
    end
  end

  def self.down
    drop_table :joomlas
  end
end
