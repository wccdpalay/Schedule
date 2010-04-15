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
end
