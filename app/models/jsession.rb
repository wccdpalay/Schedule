#Used to establish the connection to the Joomla Database for simultaneous Logins
class Jsession < ActiveRecord::Base
  Jsession.establish_connection(:joomla)
  def self.table_name() "jos_session" end
end
