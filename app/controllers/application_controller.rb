# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  
  def check_user()
    sess_id = get_joomla_session_id
    if sess_id == nil
      redirect_to :controller => :joomla, :action => :kick
    else
      sess = Jsession.find_by_session_id(sess_id)
      if sess.nil?
        session[:sess_id] = sess_id
        redirect_to :controller => :joomla, :action => :debug
      else
        if sess.username == ""
          redirect_to :controller => :joomla, :action => :kick
        else
          current_user = User.find_by_username(sess.username)
          session[:user] = current_user.id
        end
      end
    end
  end
  
  def get_user(userid)
    User.find_by_id(userid)
  end
  
  
  def admin?
    user = get_user(session[:user])
    if user #to prevent nil.usertype errors
      user.usertype == "Administrator"
    else
      redirect_to :controller => :joomla, :action => :kick
    end
  end
  
  
  def get_slots(day, col)
    case col
      when "1"
        Day.find(day).slotAs
      when "2"
        Day.find(day).slotBs
      when "3"
        Day.find(day).slotCs
      when "4"
        Day.find(day).slotDs
      else
        Day.find(day).slots
    end
  end
  
  def get_joomla_session_id
    cookies[JSESSION_NAME]
  end

end
