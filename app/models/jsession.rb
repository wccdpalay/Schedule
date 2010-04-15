class Jsession < ActiveRecord::Base
  Jsession.establish_connection(:joomla)
  def self.table_name() "jos_session" end
end
