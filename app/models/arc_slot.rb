class ArcSlot < ActiveRecord::Base
  belongs_to :day, :foreign_key => "arcDay"
  belongs_to :user
  ArcSlot.establish_connection :arc
end
