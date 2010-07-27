#A class to hold 7 days, as well as the position of the week of the year.  
class Week < ActiveRecord::Base
  # The archival system is not fully operational, but the database should be functional without it for now.
  #after_create :max_weeks

  has_many :days


  def self.new_next
    w = Week.last
    d = w.start_date
    d += 7
    w2 = Week.create({:year => d.year, :woy => d.strftime('%V').to_i, :start_date => d})
    7.times do
      day = Day.create({:date =>d, :week => w2, :being_edited => DateTime.now-2.years})
      day.name = eval(DAYS[(d.wday+1)%7])
      day.save!
      d += 1
    end
    w2
  end

  #this is an unimplemented method.  The archiving system is NOT set up to satisfaction yet.
  def max_weeks
    #if there are more than MAX_WEEKS weeks already, archive the oldest
    while Week.count > MAX_WEEKS
      archweek(Week.first)
    end
  end


  #copy a template into a new week.
  def self.make_from_template(wtemplate)
    w = Week.new_next
    w.copy_from_template(wtemplate)
    w
  end
  

  #Take an existing week, and copy a template into it
  def copy_from_template(wtemplate)
    for x in days
      x.copy_from_dtemplate(Dtemplate.find(wtemplate[x.name[5,3].to_sym])) #This is terrible terrible hacking, but
                                                                           # Rails stores the symbol as the string
                                                                           # "--- :thu\n", so I needed a way around it.
    end
  end

  def copy_from_other_week(week)

    for x in days
      x.copy_from_other_day(Day.find(:first, :conditions => {:week_id => week, :name => x.name[5,3].to_sym}))
    end

  end

  #takes the previous week and copies it into this week.
  def copy_from_previous_week
    if Week.find(self.id-1)
      copy_from_template(Week.find(self.id-1))
    end
  end


end

class ArcWeek < Week
  has_many :days, :class_name => "ArcDay", :foreign_key => "week_id" 
ArcWeek.establish_connection :arc
end