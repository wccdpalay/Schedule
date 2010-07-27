#A class attached to an archival database to hold old slots.
class ArcSlot < ActiveRecord::Base
  belongs_to :day, :foreign_key => "day_id", :class_name => "ArcDay"
  belongs_to :user
  ArcSlot.establish_connection :arc
end
