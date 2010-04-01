require "date"
class CalendarController < ApplicationController
  
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
     @sd.being_edited = DateTime.now  
     @sd.save!
    else
     flash[:notice]="This day is currently being edited.  Please try again in a few minutes."
     redirect_to (request.env["HTTP_REFERER"] ||= "/") 
    end
    
  end
  
  def update
    @day = Day.find_by_date(Date.civil(y=params[:year].to_i, m=params[:month].to_i, d=params[:day].to_i)) 
    @slots = [params[:SlotAs],params[:SlotBs],params[:SlotCs],params[:SlotDs]]
    @dslots = [@day.slotAs, @day.slotBs, @day.slotCs, @day.slotDs]

    for col in 0..3
      for slot in @slots[col]
        dslot = @dslots[col][slot[0].to_i]
        dslot.user_id = USERS[slot[1].to_sym]
        dslot.save!        
      end
    end
    @day.being_edited = (DateTime.now - 1.year)
    @day.save!
    redirect_to :controller => :calendar, :action => :view, 
                :year => params[:year], :month => params[:month], :day => params[:day]
  end
  
  
  def admin_edit
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
    redirect_to request.env["HTTP_REFERER"]
  end
  
  def admin_clear
    @day = Day.find_by_date(Date.today)
    @day.being_edited = (DateTime.now - 1.year)
    @day.save!
    redirect_to request.env["HTTP_REFERER"]
  end
  
  
end
