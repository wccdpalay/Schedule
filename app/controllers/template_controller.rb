class TemplateController < ApplicationController
  before_filter :check_user
  def index
    @wtemplate = (Wtemplate.find_by_name("Empty Template") || Wtemplate.create(:name => "Empty Template"))
    redirect_to :action => "week"
  end

  def week
    @title = "Week template"
    @wtemplate = Wtemplate.find(:all).last
  end
  
  def day
    @title = "Day Templates"
    @dtemplate = Dtemplate.find(params[:id] || :last)
  end

  def list_weeks
    @title = "Week listing"
    @weeks = Wtemplate.find(:all)
  end

  def list_days
    @title = "Day Listing"
    @days = Dtemplate.find(:all)
  end
  
  def edit_week
    @week = Wtemplate.find(params[:id])
    @title = "Edit details of #{@week.name}"
  end

  def edit_day
    @day = Dtemplate.find(params[:id])
    @title = "Edit details of #{@day.name}"
  end

  def rename_week
    @week = Wtemplate.find(params[:id])
    @week.name = params[:name]
    @week.save!
    redirect_to :action =>"list_weeks"
  end
  def rename_day
    @day = Dtemplate.find(params[:id])
    @day.name = params[:name]
    @day.save!
    redirect_to :action => "list_days"
  end

  def delete_week
    @week = Wtemplate.find(params[:id])
    @week.delete
    redirect_to :action => :week
  end

  def delete_day
    @day = Dtemplate.find(params[:id])
    @day.delete
    redirect_to :action => :day
  end

  def new_week
    @week = Wtemplate.create()
    @week.name = params[:wtemplate][:name]
      if params[:wtemplate][:more] == "1"
        for x in [:sat, :sun, :mon, :tue, :wed, :thu, :fri]
          @week[x] = Wtemplate.find(params[:wtemplate][:copy_from])[x]
        end
      end
    @week.save!
    respond_to do |format|
      format.html {redirect_to :action => "view", :id => @week}
      format.js  {}
    end
  end


  def new_day
    @dtemplate = Dtemplate.create()
    @dtemplate.name = params[:dtemplate][:name]
    if params[:dtemplate][:more] == "1"
      @dtemplate.copy_from_dtemplate(Dtemplate.find(params[:dtemplate][:copy_from]))
    end
    @dtemplate.save!
    respond_to do |format|
      format.html {redirect_to :action => "day", :id => @dtemplate}
      format.js {}
    end
  end


  def change_week
    @week = Wtemplate.find(params[:value])
    params[:id] = params[:value]
    respond_to do |format|
      format.html {redirect_to :action => "week", :id => @week}
      format.js  {}
    end
  end

  def change_day
    @day = Dtemplate.find(params[:value])
    params[:id] = params[:value]
    respond_to do |format|
      format.html {redirect_to :action => "day", :id => @day}
      format.js  {}
    end
  end
  


  def update_week
    @wtemplate = Wtemplate.find(params[:id])
    @wtemplate[:sat] = params[:day]["1"]
    @wtemplate[:sun] = params[:day]["2"]
    @wtemplate[:mon] = params[:day]["3"]
    @wtemplate[:tue] = params[:day]["4"]
    @wtemplate[:wed] = params[:day]["5"]
    @wtemplate[:thu] = params[:day]["6"]
    @wtemplate[:fri] = params[:day]["7"]
    @wtemplate.save!
    respond_to do |format|
      format.html {redirect_to :action => "week", :id => @wtemplate.id}
      format.js  {}
    end
  end


  def update_day
    @day = Dtemplate.find_by_id(params[:id])
    @slots = [params[:slotAs],params[:slotBs],params[:slotCs],params[:slotDs]]
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
    @day.save!
    respond_to do |format|
      format.html {redirect_to :action => "day", :id => params[:id]}
      format.js  {}
    end
  end
end
