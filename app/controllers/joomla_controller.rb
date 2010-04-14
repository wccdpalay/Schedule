class JoomlaController < ApplicationController
  
  
  def index  
    @content = get_joomla_session_id
    
    sql = ActiveRecord::Base.establish_connection(:joomla).connection
    @session = Session.find_by_session_id(@content)
    @user = User.find_by_username(@session.username)
  end
  
  
end
