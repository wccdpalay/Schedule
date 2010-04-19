# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  
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
          session[:user] = current_user
        end
      end
    end
  end
  
  def admin?
    if session[:user]
      session[:user].usertype != "Administrator"
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
