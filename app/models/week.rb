class Week < ActiveRecord::Base
  has_many :days
  
 def next
   Week.find(:all, {:order => "start_date DESC"}).last
    
  end
  
  def make_from_template(wtemplate)
    
  end
  
  
  def copy_from_template(wtemplate)
    for x in 0..days.length-1
      days[x].copy_from_template(Dtemplate.find(wtemplate[DAYS[x]]))
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