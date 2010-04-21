require "date"
module CalendarHelper
  
  def get_start_day(year, month, day)
    Day.find_by_date(Date.new(year.to_i, month.to_i, day.to_i))
  end
  
  def close_at_5(day)
    close_at_time(day, "5:00 PM")
  end
  
  def close_at_7(day)
    close_at_time(day, "7:00 PM")
  end
  
  def close_at_time(day, time)
    for index in (ALL_TIMES.index(time)-1)..ALL_TIMES.length
      for slot in day.slots.find_all_by_start_time(index)
        slot.user_id = -2
        slot.save!
      end
    end
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
