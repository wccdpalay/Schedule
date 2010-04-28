class Wtemplate < ActiveRecord::Base
  
  belongs_to :sat, {:class_name => "Dtemplate", :foreign_key => :sat}
  belongs_to :sun, {:class_name => "Dtemplate", :foreign_key => :sun}
  belongs_to :mon, {:class_name => "Dtemplate", :foreign_key => :mon}
  belongs_to :tue, {:class_name => "Dtemplate", :foreign_key => :tue}
  belongs_to :wed, {:class_name => "Dtemplate", :foreign_key => :wed}
  belongs_to :thu, {:class_name => "Dtemplate", :foreign_key => :thu}
  belongs_to :fri, {:class_name => "Dtemplate", :foreign_key => :fri}
  
  
  def before_create
    
  end
  
  def after_save
    
  end
  
  def save_as(str)
    
  end
  
  def sym_days
    [:sat, :sun, :mon, :tue, :wed, :thu, :fri]
  end
  
  def days
    [sat, sun, mon, tue, wed, thu, fri]
  end
  
end
