class JoomlaController < ApplicationController
  def index
    
    open('https://serafina.labs.is.wccnet.org/joomla/tech.php') do |page|
      @content = page.read
      # do something with content
    end
    #@content = `/Library/WebServer/Documents/Joomla/tech.php`
    
    params[:cookie_name] = @content
    @content = cookies[params[:cookie_name]]
    
    sql = ActiveRecord::Base.establish_connection(:joomla).connection
    @result = sql.execute("SELECT * FROM jos_session WHERE session_id = '#{@content}';")
    @row = @result.fetch_row
  end
end
