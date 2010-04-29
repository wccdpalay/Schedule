class Dtemplate < ActiveRecord::Base
  
  has_many :stemplates
  has_many :sats, {:class_name=> 'Wtemplate', :foreign_key => 'sat'}
  has_many :suns, {:class_name=> 'Wtemplate', :foreign_key => 'sun'}
  has_many :mons, {:class_name=> 'Wtemplate', :foreign_key => 'mon'}
  has_many :tues, {:class_name=> 'Wtemplate', :foreign_key => 'tue'}
  has_many :weds, {:class_name=> 'Wtemplate', :foreign_key => 'wed'}
  has_many :thus, {:class_name=> 'Wtemplate', :foreign_key => 'thu'}
  has_many :fris, {:class_name=> 'Wtemplate', :foreign_key => 'fri'}
  
  
  def slotAs
    self.stemplates.find_all_by_spot "A"
  end
  
  def slotBs
    self.stemplates.find_all_by_spot "B"
  end
  
  def slotCs
    self.stemplates.find_all_by_spot "C"
  end
  
  def slotDs
    self.stemplates.find_all_by_spot "D"
  end
  
  def copy_from_day(day)
    
  end
  
  def after_create
    for i in 0..47
      sa = self.stemplates.build
      sa.spot = "A"
      sa.start_time = i
      sa.save!
      
      sb = self.stemplates.build
      sb.spot = "B"
      sb.start_time = i
      sb.save!
      
      sc = self.stemplates.build
      sc.spot = "C"
      sc.start_time = i
      sc.save!
      
      sd = self.stemplates.build
      sd.spot = "D"
      sd.start_time = i
      sd.save!
    end
  end
  
end

