# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :check_user
  
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
      if sess.username != ""
        current_user = User.find_by_username(sess.username)
        session[:user] = current_user
      else
        redirect_to :controller => :joomla, :action => :kick
      end
    end
  end
  
  def admin?
    if session[:user]
      session[:user].user_type == "Administrator"
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
    open('https://serafina.labs.is.wccnet.org/joomla/tech.php') do |page|
      session[:cookie_name] = page.read
      # do something with content
    end
    #session[:cookie_name] = `/Library/WebServer/Documents/Joomla/tech.php`
    cookies[session[:cookie_name]]
  end

end
