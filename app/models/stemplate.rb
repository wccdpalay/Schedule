class Stemplate < ActiveRecord::Base
  belongs_to :dtemplate
  belongs_to :user

  def copy_from_stemplate(stemp)
    dtemplate_id = stemp.dtemplate_id
    start_time = stemp.start_time
    user_id = stemp.user_id
    spot = stemp.spot
    save!
  end

end


class SAt < Stemplate
  def self.new()
    Stemplate.new(:spot => "A")
  end
  
  def self.find_first
    Stemplate.find(:first, :conditions => ["spot = ?", "A"])
  end
  
  def self.find_all
    Stemplate.find(:all, :conditions => [ "spot = ?", "A"])
  end
end

class SBt < Stemplate
  def self.new
    Stemplate.new(:spot => "B")
  end
  
  def self.find_first
    Stemplate.find(:first, :conditions => ["spot = ?", "B"])
  end
  
  def self.find_all
    Stemplate.find(:all, :conditions => [ "spot = ?", "B"])
  end
end

class SCt < Stemplate
  
  def self.find_first
    Stemplate.find(:first, :conditions => ["spot = ?", "C"])
  end
  
  def self.find_all
    Stemplate.find(:all, :conditions => [ "spot = ?", "C"])
  end
  
  def self.new
    Stemplate.new(:spot => "C")
  end  
end

class SDt < Stemplate
  def self.new
    Stemplate.new(:spot => "D")
  end
  
  def self.find_first
    Stemplate.find(:first, :conditions => ["spot = ?", "D"])
  end
  
  def self.find_all
    Stemplate.find(:all, :conditions => [ "spot = ?", "D"])
  end
end