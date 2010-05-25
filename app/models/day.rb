class Day < ActiveRecord::Base

  belongs_to :week
  has_many :slots
  
  def self.today
    return Day.find_by_date(Date.today)
  end
  
  def slotAs
    self.slots.find_all_by_spot "A"
  end
  
  def slotBs
    self.slots.find_all_by_spot "B"
  end
  
  def slotCs
    self.slots.find_all_by_spot "C"
  end
  
  def slotDs
    self.slots.find_all_by_spot "D"
  end
  
  
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
  
  
    #TODO: Finish check_for_empty? so that I can have an automated email
    #TODO: Create an automatic emailer
    #Returns true if there is an shift with no one scheduled
  def check_for_empty?(start_time, end_time)
    
  end
  
  def copy_from_dtemplate(dtemp)
    for x in 0..slots.length-1
      slots[x].start_time = dtemp.stemplates[x].start_time
      slots[x].user_id = dtemp.stemplates[x].user_id
      slots[x].spot = dtemp.stemplates[x].spot
      slots[x].save!
    end
  end
 
end

class ArcDay < Day
  
  belongs_to :arcweek, :foreign_key => "week_id" 
  has_many :arcslots, :foreign_key => "slot_id"
  
ArcDay.establish_connection :arc
end