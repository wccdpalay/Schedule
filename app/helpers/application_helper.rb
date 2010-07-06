# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


  def get_user(user)
    User.find(session[:user])
  end

  
  def admin?
    user = get_user(session[:user])
    if user
      user.usertype == "Administrator"
    end
  end

  def current_user
    session[:username]
  end
  
  def link_to_cal(string, date, length="day")
    link_to string, {:controller => :calendar, :action => :view, 
                  :length => length, :year => date.year, 
                  :month => date.month, :day => date.day}
  end
  
  

  def options_from_users(slot=nil, tuser=nil)
    options = ""
    select_used = false
    if slot != nil
      if slot.user_id == -1
        options = "<option selected=\"selected\" value='-1'>Blocked</option><option value='-2'>Closed</option>"
        select_used = true
      elsif slot.user_id == -2
        options = "<option value='-1'>Blocked</option><option selected=\"selected\" value='-2'>Closed</option>"
        select_used = true
      else
        options = "<option value='-1'>Blocked</option><option value='-2'>Closed</option>"  
      end
    else
      if tuser == nil
        options = "<option value='-1'>Blocked</option><option value='-2'>Closed</option>"
      end
    end
    for user in User.find(:all)
      if slot != nil
        if slot.user == user
          select_used = true
          options += "<option selected=\"selected\" value='#{user.id}'>"+user.firstname+"</option> "
        else
          options += "<option value='#{user.id}'>"+user.firstname+"</option> "
        end
      else #slot == nil
        if tuser == user.id
          select_used = true
          options += "<option selected=\"selected\" value='#{user.id}'>"+user.firstname+"</option> "
        else
          options += "<option value='#{user.id}'>"+user.firstname+"</option> "
        end
      end
    end
    if select_used
      options = "<option value='nil'> - </option>" + options
    else
      options = "<option selected=\"selected\" value='nil'> - </option>" + options
    end
    options
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

    def get_user_for_slot_short(slot)
    case slot.user_id
      when nil
        ""
      when -1
        "Blocked"
      when -2
        "Closed"
      else
        slot.user.firstname
    end
  end
  
  #Template stuff
  def options_for_wtemplates
    options = ""
    for op in Wtemplates.find(:all)
      if op != nil
          options += "<option>"+op.name.to_s+"</option> "
      end
    end
    options
  end
  
  def options_for_dtemplates
    
  end
end
