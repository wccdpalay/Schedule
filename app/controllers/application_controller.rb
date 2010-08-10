# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  #Moves a given object to the Archive Databse
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

  #Get the currently logged in user from the Joomla Sessions Table
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
          session[:username] = current_user.username
        end
      end
    end
  end

  #Get the User from an ID
  def get_user(userid)
    User.find_by_id(userid)
  end
  

  #Check if the User is an admin
  def admin?
    user = get_user(session[:user])
    if user #to prevent nil.usertype errors
      (current_user != "dpalay" && user.usertype == "Administrator")
    else
      redirect_to :controller => :joomla, :action => :kick
    end
  end
  

  #Return the Slot for a given Day and its column
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

  #Get the Session ID from the Joomla Cookie
  def get_joomla_session_id
    cookies[JSESSION_NAME]
  end

end
