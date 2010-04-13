class Joomla < ActiveRecord::Base
  Joomla.establish_connection :joomla
  attr_accessor :jinfo
end
