class Slot < ActiveRecord::Base
  belongs_to :day
  belongs_to :user


end

class SlotA < Slot
  def self.new()
    s = Slot.new(:spot => "A")
  end
  
  def self.find_first
    Slot.find(:first, :conditions => ["spot = ?", "A"])
  end
  
  def self.find_all
    Slot.find(:all, :conditions => [ "spot = ?", "A"])
  end
end

class SlotB < Slot
  def self.new
    s = Slot.new(:spot => "B")
  end
  
  def self.find_first
    Slot.find(:first, :conditions => ["spot = ?", "B"])
  end
  
  def self.find_all
    Slot.find(:all, :conditions => [ "spot = ?", "B"])
  end
end

class SlotC < Slot
  
  def self.find_first
    Slot.find(:first, :conditions => ["spot = ?", "C"])
  end
  
  def self.find_all
    Slot.find(:all, :conditions => [ "spot = ?", "C"])
  end
  
  def self.new
    s = Slot.new(:spot => "C")
  end  
end

class SlotD < Slot
  def self.new
    s = Slot.new(:spot => "D")
  end
  
  def self.find_first
    Slot.find(:first, :conditions => ["spot = ?", "D"])
  end
  
  def self.find_all
    Slot.find(:all, :conditions => [ "spot = ?", "D"])
  end
end


