class CalendarController < ApplicationController
  before_filter :check_user
  
  include CalendarHelper
  def index
    @start_day = Date.today
    redirect_to :action => :view
  end
  
  def view
    @title = "Schedule"
    
    
    #When to start the showing
    if params[:date]
      @start_day = get_start_day(params[:date][:year], params[:date][:month], params[:date][:day])
    elsif params[:year]
      @start_day = get_start_day(params[:year], params[:month], params[:day])
    else
      @start_day = Day.find_by_date(Date.today)
    end
  
    @sd = @start_day
    
    #find out the Saturday before
    @start_sat = Day.find(@start_day)
    while @start_sat.date.wday < 6
     @start_sat = Day.find_by_date(@start_sat.date-1) 
    end

    #How many days are we showing?
    if params[:length] == "day"
      @length = 1
    elsif (params[:length] == "week") || (params[:length] == "7")
      @length = 7
      @start_day = @start_sat
    elsif params[:length] == nil
      @length = 1
    elsif params[:length] == "fortnight"
      @length = 14
    else
      @length = params[:length]
    end
    
  end
  
  def edit
    @title = "Editing Schedule"
    
    #When to start the showing
    if params[:date]
      @start_day = get_start_day(params[:date][:year], params[:date][:month], params[:date][:day])
    elsif params[:year]
      @start_day = get_start_day(params[:year], params[:month], params[:day])
    else
      @start_day = Day.find_by_date(Date.today)
    end
  
    @sd = @start_day
    
    #find out the Saturday before
    @start_sat = Day.find(@start_day)
    while @start_sat.date.wday < 6
     @start_sat = Day.find_by_date(@start_sat.date-1) 
    end

    @length = 1
    
    #completely unsatisfied with Rail's Locking mechanism, I'm writing my own.  
    #On an edit, the Day#being_edited attribute is updated to the current time.  If the attribute is within
    #the EDITLAG set in the environment, then it is "locked".
  
    if @sd.being_edited < (DateTime.now - 2.minutes)
    #if true
     @sd.being_edited = DateTime.now  
     @sd.save!
    else
     flash[:notice]="This day is currently being edited.  Please try again in a few minutes."
     redirect_to (request.env["HTTP_REFERER"] ||= "/") 
    end
    
  end
  
  def update
    Day.transaction do
      Slot.transaction do
        @day = Day.find_by_date(Date.civil(params[:year].to_i, params[:month].to_i, params[:day].to_i))
        if admin?
          @slots = [params[:SlotAs],params[:SlotBs],params[:SlotCs],params[:SlotDs]]
          @dslots = [@day.slotAs, @day.slotBs, @day.slotCs, @day.slotDs]
      
          for col in 0..3
            for slot in @slots[col]
              dslot = @dslots[col][slot[0].to_i]
              if slot[1] != 'nil'
                dslot.user_id = slot[1]
              else
                dslot.user_id = nil
              end
              dslot.save!        
            end
          end
          @day.being_edited = (DateTime.now - 1.year)
          @day.save!
          
        else
          @rows = params[:row]
          @sa = []
          @sb = []
          @sc = []
          @sd = []
          @se = []
          @rows.each { |key, val|
            eval("@" + val.to_s) << key
          }
          
          for x in @sa
            slot = @day.slotAs[x.to_i]
            slot.user_id = session[:user]
            slot.save!
          end
          for x in @sb
            slot = @day.slotBs[x.to_i]
            slot.user_id = session[:user]
            slot.save!
          end
          for x in @sc
            slot = @day.slotCs[x.to_i]
            slot.user_id = session[:user]
            slot.save!
          end
          for x in @sd
            slot = @day.slotDs[x.to_i]
            slot.user_id = session[:user]
            slot.save!
          end
          for x in @se
            slot = @day.slotAs[x.to_i]
            slot.user = nil
            slot.save!
          end
        end
        session[:current_user_hours] = get_user(session[:user]).weeks_hours(@day.week)
        if session[:current_user_hours].to_f > 20.0.to_f
          #stop the transaction, redirect back to edit
          flash[:warning] = "You have more than 20 hours scheduled."
        end
      end
    end  
    @day.being_edited = DateTime.now - 3.minutes
    redirect_to :controller => :calendar, :action => :view, 
      :year => params[:year], :month => params[:month], :day => params[:day]  
  end
  
  
  
  def admin_edit
    @title = "Administrative Edit"
    @day = Day.find_by_date(params[:day])
    if params[:col] != nil
      @args = get_slots(@day, params[:col])
    else
      @args = @day.slots
    end
    if params[:uid]
      eval("#{params[:method]}(@args, #{params[:uid]})")
    else
      eval("#{params[:method]}(@args)")
    end
    redirect_to request.env["HTTP_REFERER"] ||= {:controller => :calendar, :action => :view}
  end
  
  def admin_clear
    @day = Day.find_by_date(Date.today)
    @day.being_edited = (DateTime.now - 1.year)
    @day.save!
    redirect_to request.env["HTTP_REFERER"] ||= {:controller => :calendar, :action => :view}
  end
  
  
end
