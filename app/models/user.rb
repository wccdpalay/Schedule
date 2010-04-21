class User < ActiveRecord::Base
  has_many :slots
  has_many :stemplates
  User.establish_connection(:joomla)
  def self.table_name() "jos_users" end




  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate()
    content = nil
    open('https://serafina.labs.is.wccnet.org/joomla/tech.php') do |page|
      content = page.read
    end
    #content = `/Library/WebServer/Documents/Joomla/tech.php`
    
    params[:cookie_name] = content
    content = cookies[params[:cookie_name]]
    sql = 
    result = sql.execute("SELECT * FROM jos_session WHERE session_id = '#{@content}';")
    row = result.fetch_hash
    username = row["username"]
    user["username"] == "" ? nil : User.find_by_username(username)
  end
  
  def self.make_new(name, username, usertype)
    current_user = User.new({:name => name, :username => username, :usertype => usertype})
  end
  
  def self.firstname()
    name.gsub(/(\.|\s)[a-zA-Z]*/, "")
  end
end