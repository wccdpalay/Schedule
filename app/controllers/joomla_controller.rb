class JoomlaController < ApplicationController
  def index
    
    open('https://serafina.labs.is.wccnet.org/joomla/tech.php') do |page|
      @content = page.read
      # do something with content
    end
    #@content = `/Library/WebServer/Documents/Joomla/tech.php`

  end
end
