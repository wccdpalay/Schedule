class User < ActiveRecord::Base
  has_many :slots
  has_many :stemplates


  attr_accessor :name, :username, :usertype


  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate()
    content = nil
    open('https://serafina.labs.is.wccnet.org/joomla/tech.php') do |page|
      content = page.read
    end
    #content = `/Library/WebServer/Documents/Joomla/tech.php`
    
    params[:cookie_name] = content
    content = cookies[params[:cookie_name]]
    sql = User.establish_connection(:joomla).connection
    result = sql.execute("SELECT * FROM jos_session WHERE session_id = '#{@content}';")
    row = result.fetch_hash
    username = row["username"]
    uresult = sql.execute("SELECT * FROM jos_users WHERE username = '#{username}'")
    user = uresult.fetch_hash
    user["username"] == "" ? nil : user["username"]
  end
  
  def self.make_new(name, username, usertype)
    current_user = User.new({:name => name, :username => username, :usertype => usertype})
  end
  
end