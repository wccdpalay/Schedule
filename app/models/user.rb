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
    result = sql.execute("SELECT * FROM jos_session WHERE session_id = '#{@content}';")
    row = result.fetch_hash
    username = row["username"]
    user["username"] == "" ? nil : User.find_by_username(username)
  end
  
  def self.make_new(name, username, usertype)
    current_user = User.new({:name => name, :username => username, :usertype => usertype})
  end
  
  def firstname()
    name.gsub(/(\.|\s)[a-zA-Z]*/, "")
  end
  
  def weeks_hours(week = Day.find_by_date(Date.today).week)
    hours_total = 0
    for slot in slots
      if slot.day.week == week
        hours_total += 0.5
      end
    end
    hours_total
  end
end