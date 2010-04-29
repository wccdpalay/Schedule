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
