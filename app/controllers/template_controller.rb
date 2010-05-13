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
end
