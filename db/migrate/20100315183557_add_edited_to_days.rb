class AddEditedToDays < ActiveRecord::Migration
  

  def self.up
    add_column :days, :being_edited, :datetime
  end

  def self.down
    remove_column :days, :being_edited
  end
end
