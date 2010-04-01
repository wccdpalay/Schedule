class TemplateController < ApplicationController
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
