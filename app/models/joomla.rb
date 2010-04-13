class Joomla < ActiveRecord::Base
  
  serialize :info
  
  sql = ActiveRecord::Base.establish_connection(:joomla).connection
  
end
