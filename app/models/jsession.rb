class JSession < ActiveRecord::Base
  JSession.establish_connection(:joomla)
  def self.table_name() "jos_session" end
end
