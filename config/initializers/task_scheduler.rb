require 'chronic'

def archive(obj)
  if obj.class == (SlotA || SlotB || SlotC || SlotD)
    oldobjclass = ArcSlot
  else
    oldobjclass = eval('Arc'+obj.class.to_s)
  end
  newobj = oldobjclass.new(obj.attributes)
  newobj.id = obj.id
  newobj.save!
  obj.destroy
end

#Archive a given week, it's days, and their slots
def archweek(w)
  #for each day of the week
    for day in w.days
      
    #for each slotA of day
      for slot in day.slotAs
        #archive
        archive(slot)
      end
      
    #for each slotB of day
      for slot in day.slotBs
        #archive
        archive(slot)
      end
      
    #for each slotC of day
      for slot in day.slotCs
        #archive
        archive(slot)
      end
      
    #for each slotD of day
      for slot in day.slotDs
        #archive
        archive(slot)
      end
      
    #archive day
    archive(day)
  end
  #archive week
  archive(w)
end

def initweek(w)
  w.init = true
  w.save!
end

def init_year(year)
#puts "starting year #{year}"
#puts "making new date"
  date = Date.new(year, 1, 1)
#puts "check for leap year"
  unless date.leap?
    days = 365
  else
    days = 366
  end
#puts "#{days} in the year"

  woy = 1
   
  #check for what week to put it in
   #if the previous year was initialized
  if Week.find_by_year(year-1)
    #check if the last year ended on a friday
    unless Week.find_all_by_year(year-1).last.days.last.date.wday == 5 #unless friday
      #change week of year to be the previous week (the last week of the previous year)
      w = Week.find_all_by_year(year-1).last
    else #else we DID end on a friday, and the first day is a new week
      #puts "Making new week ##{woy}"
      w = Week.new({:year => year, :woy => woy})
    end
  else
  w = Week.new({:year => year, :woy => woy})
  end
      
    #find the start of the week
  start_sat = date
  while start_sat.wday < 6
   start_sat -= 1 
  end
  w.start_date = start_sat
  
  w.save!
#puts "Week #{woy} saved with start_date = #{w.start_date}"
#puts "Making new day"
  d = Day.new({:date => date, :week => w})
  d.save!
#puts "Saved #{d.date}"
  days -= 1
    
  while days > 0
      #If it's Friday, make a new week
    if d.date.wday == 5
      woy += 1
      w = Week.new({:year => year, :woy => woy, :start_date => d.date+1})
      w.save!
#puts "Week #{woy} saved with start_date = #{w.start_date}"        
    end
    d = Day.new({:date => d.date.tomorrow, :week => w})
    d.save!
#puts "Saved #{d.date}"
    days -= 1
  end
end

schedule_check = Rufus::Scheduler::PlainScheduler.start_new(
    :thread_name => 'Checking For Blanks')

archiver = Rufus::Scheduler::PlainScheduler.start_new(
    :thread_name => 'The Archiver')
    
addyear = Rufus::Scheduler::PlainScheduler.start_new(
    :thread_name => 'New Year adder')
  

  
  #Every day at 00:01, check for the NEXT day's schedule
  schedule_check.cron("1 0 * * 0-6") do  
    puts("DailyDigest.send_digest!")  
    if Day.find_by_date(Date.today+1).check_for_empty?
      puts("Need to send email to warn Dan!!")
    else
      puts("all is well!")
    end
  end
  

#Every week, take the oldest week and archive it
  archiver.every '1w', :first_at => Chronic.parse('next saturday', 
                            :now => Chronic.parse('next saturday')) do
    archweek(Week.find(:first))
    initweek()
  end
  
#in December, create next year.
 addyear.every('1y', :first_at => Chronic.parse('December 20')) do
   init_year(Date.today.year)
 end