class JoomlaController < ApplicationController
  before_filter :check_user, :except => [:debug, :kick]
  
  
  def index  
    @content = get_joomla_session_id
    
    @session = Jsession.find_by_session_id(@content)
    @user = User.find_by_username(@session.username) unless @session.nil?
  end
  
  def kick
    @message = "Your session has either expired or never existed.  
    Please go back and log into Serafina's main page"
  end
  
  def debug
    @user = get_user(session[:user])
    @result_from_php = JSESSION_NAME
    @cookie_contents = cookies[@result_from_php]
    @jsessions = Jsession.find(:all)
  end
end
