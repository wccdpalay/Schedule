class JoomlaController < ApplicationController
  before_filter :check_user, :except => [:debug, :kick]
  
  
  def index  
    @content = get_joomla_session_id
    
    @session = Jsession.find_by_session_id(@content)
    @user = User.find_by_username(@session.username) unless @session.nil?
  end
  
  def kick
    @message = "Your session has either expired or never existed.  
    Please go back and refresh Serafina's main page"
  end
  
  def debug
    @user = get_user(session[:user])
    @result_from_php = JSESSION_NAME
    @cookie_contents = cookies[@result_from_php]
    @jsessions = Jsession.find(:all)
    params[:error] ||= "Your session has timed out.  Please refresh the front page of serafina and try again."
  end
end
