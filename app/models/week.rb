class Week < ActiveRecord::Base
  has_many :days

  after_create :max_weeks


  def max_weeks
    #if there are more than MAX_WEEKS weeks already, archive the oldest
    while Week.count > MAX_WEEKS
      archweek(Week.first)
    end
  end

  def make_from_template(wtemplate)
    
  end
  
  
  def copy_from_template(wtemplate)
    for x in days
      x.copy_from_dtemplate(Dtemplate.find(wtemplate[x.name]))
    end
  end

  def copy_from_other_week(week)

    for x in days
      x.copy_from_other_day(Day.find(:first, :conditions => {:week_id => week, :name => x.name}))
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