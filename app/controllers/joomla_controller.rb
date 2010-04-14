class JoomlaController < ApplicationController
  
  
  def index  
    @content = get_joomla_session_id
    
    @session = Jsession.find_by_session_id(@content)
    @user = User.find_by_username(@session.username) unless @session.nil?
  end
  
  
end
