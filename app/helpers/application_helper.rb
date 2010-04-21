# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def admin?
    if session[:user]
      session[:user].usertype == "Administrator"
    end
  end
  
  def link_to_cal(string, date, length="day")
    link_to string, {:controller => :calendar, :action => :view, 
                  :length => length, :year => date.year, 
                  :month => date.month, :day => date.day}
  end
  
  
  
  def options_from_users(slot=nil)
    options = ""
    select_used = false
    for user in User.find(:all)
      if slot != nil
        if slot.user == user
          select_used = true
          options += "<option selected=\"selected\">"+user.name.gsub(/\s[a-zA-Z]*/, "")+"</option> "
        else
          options += "<option>"+user.name.gsub(/\s[a-zA-Z]*/, "")+"</option> "
        end
      else #slot == nil
        options += "<option>"+user.name.gsub(/\s[a-zA-Z]*/, "")+"</option> "
      end
    end
    if select_used
      options = "<option> - </option>" + options
    else
      options = "<option selected=\"selected\">" + options
    end
    options
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
