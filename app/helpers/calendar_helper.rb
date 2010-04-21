require "date"
module CalendarHelper
  
  def get_start_day(year, month, day)
    Day.find_by_date(Date.new(year.to_i, month.to_i, day.to_i))
  end
  
  
  #the reason for the slots in these methods is the admin_edit method in the controller
  #passes along a group of Slots as the argument to the methods.  Rather than rewrite 
  #admin_edit and complicate it further, I decided to just grab the day from the slots
  #passed to these methods
  def close_at_5(slots)
    close_at_time(slots.first.day, "5:00 PM")
  end
  
  def close_at_7(slots)
    close_at_time(slots.first.day, "7:00 PM")
  end
  
  def close_at_10(slots)
    close_at_time(slots.first.day, "10:00 PM")
  end
  
  def close_at_time(day, time)
    #open all closed, before closing after the time
    for slot in day.slots
      if (ALL_TIMES.index(time)..ALL_TIMES.length-1).include? slot.start_time
        slot.user_id = -2
        slot.save!
      elsif slot.user_id == -2
        slot.user_id = nil
        slot.save!
      end
    end
  end

  
    
#        if slot.user_id = -2
#          slot.user_id = nil
#          slot.save!
#        end
#      end
#    for index in (ALL_TIMES.index(time)-1)..ALL_TIMES.length
#      for slot in day.slots.find_all_by_start_time(index)
#        slot.user_id = -2
#        slot.save!
#      end
#    end
  end
  
  def alter_block(block, uid=nil)
    for slot in block
      slot.user_id = uid
      slot.save!
    end
  end
  
  def get_user_for_slot(slot)
    case slot.user_id
      when nil
        "&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;"
      when -1
        "Blocked"
      when -2
        "Closed"
      else
        slot.user.firstname
    end
  end
  
end
