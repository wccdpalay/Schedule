class TemplateController < ApplicationController
  before_filter :check_user
  def index
    
  end
  
  def week
    @wtemplate = Wtemplate.find(:all).last
  end
  
  def view
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def change_day
#    respond_to do |format|  
#      format.html
#      
#      format.js  {}
#    end
  end
end
