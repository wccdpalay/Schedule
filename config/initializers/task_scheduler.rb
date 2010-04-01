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

def initweek()
  
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
  archiver.every '1w', :first_in => Chronic.parse('next saturday', 
                            :now => Chronic.parse('next saturday')) do
    archweek(Week.find(:first))
    initweek()
  end
  
#in December, create next year.