class Week < ActiveRecord::Base
  has_many :days
  
 def next
   Week.find(:all, {:order => "start_date DESC"}).last
    
  end
  
  def make_from_template(template)
    w = Week.next
    
  end
  
  
  def copy_from_template(temp)
    transaction do
      for x in 0..self.days.length-1
        tday = temp.days[x]
        day = self.days[x]
        for y in 0..day.slots.length-1
          slot = day.slots[y]
          tslot = tday.slots[y]
          slot.user = tslot.user
          slot.save!
        end
      end  
    end
  end
  
  def copy_from_previous_week
    if Week.find(self.id-1)
      copy_from_template(Week.find(self.id-1))
    end
  end
end

class ArcWeek < Week
  has_many :days, :class_name => "ArcDays", :foreign_key => "week_id" 
ArcWeek.establish_connection :arc
end