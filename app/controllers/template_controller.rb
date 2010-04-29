class TemplateController < ApplicationController
  before_filter :check_user
  def index
    @wtemplate = (Wtemplate.find_by_name("Empty Template") || Wtemplate.create(:name => "Empty Template"))
    redirect_to :action => "week"
  end

  def week
    @wtemplate = Wtemplate.find(:all).last
  end

  def view

  end

  def edit

  end


  def update
    @wtemplate = Wtemplate.find(params[:id])

    for x in 1..7
        @wtemplate[@wtemplate.days[x-1]] = params[:day][x.to_s]
        @wtemplate.save!
    end
    respond_to do |format|
      format.html {redirect_to :action => "week", :id => @wtemplate.id}

      format.js  {}
    end
  end
end
