# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def admin?
    session[:user].usertype == "Administrator"
  end
  
  def link_to_cal(string, date, length="day")
    link_to string, {:controller => :calendar, :action => :view, 
                  :length => length, :year => date.year, 
                  :month => date.month, :day => date.day}
  end
  
  def options_from_users(slot=nil)
    options = ""
    for user in USERS.keys
      if slot != nil
        if slot.user_id == USERS[user]
          options += "<option selected=\"selected\">"+user.to_s+"</option> "
        else
          options += "<option>"+user.to_s+"</option> "
        end
      else #slot == nil
        options += "<option>"+user.to_s+"</option> "
      end
      
    end
    options
  end
  
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
