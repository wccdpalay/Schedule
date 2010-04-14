class Session < ActiveRecord::Base
  Session.establish_connection(:joomla)
  def self.table_name() "jos_session" end
end
