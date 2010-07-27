#A class representing a Day.  Each Day contains 4 groups of 48 Slots, each with an associated time.  A day also has a Date, Name (weekday), Week ID
class Day < ActiveRecord::Base

  belongs_to :week
  has_many :slots

  #Returns the current Day
  def self.today
    return Day.find_by_date(Date.today)
  end

  #Returns the 1st column of Slots
  def slotAs
    self.slots.find_all_by_spot "A"
  end

  #Returns the 2nd column of Slots
  def slotBs
    self.slots.find_all_by_spot "B"
  end

  #Returns the 3rd column of Slots
  def slotCs
    self.slots.find_all_by_spot "C"
  end

  #Returns the 4th column of Slots
  def slotDs
    self.slots.find_all_by_spot "D"
  end
  
  
  #Filter.  After creating the day, it creates the 48*4 slots.
  def after_create
    for i in 0..47
      sa = self.slots.build
      sa.spot = "A"
      sa.start_time = i
      sa.save!
      
      sb = self.slots.build
      sb.spot = "B"
      sb.start_time = i
      sb.save!
      
      sc = self.slots.build
      sc.spot = "C"
      sc.start_time = i
      sc.save!
      
      sd = self.slots.build
      sd.spot = "D"
      sd.start_time = i
      sd.save!
    end
  end
  
  
  #Given a dtemplate, creates a new Day with the same setup
  def copy_from_dtemplate(dtemp)
    for x in 0..slots.length-1
      slots[x].start_time = dtemp.stemplates[x].start_time
      slots[x].user_id = dtemp.stemplates[x].user_id
      slots[x].spot = dtemp.stemplates[x].spot
      slots[x].save!
    end
  end

  #Given another Day, creates a new Day with the same setup
  def copy_from_other_day(o_day)
     for x in 0..slots.length-1
      slots[x].start_time = o_day.slots[x].start_time
      slots[x].user_id = o_day.slots[x].user_id
      slots[x].spot = o_day.slots[x].spot
      slots[x].save!
    end
  end

end


#A class attached to an archival database to hold old Days
class ArcDay < Day
  
  belongs_to :arcweek, :foreign_key => "week_id" 
  has_many :slots, :foreign_key => "slot_id"
  
ArcDay.establish_connection :arc

end