class Stemplate < ActiveRecord::Base
  belongs_to :dtemplate
  belongs_to :user
end


class SAt < Stemplate
  def self.new()
    s = Stemplate.new(:spot => "A")
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
    s = Stemplate.new(:spot => "B")
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
    s = Stemplate.new(:spot => "C")
  end  
end

class SDt < Stemplate
  def self.new
    s = Stemplate.new(:spot => "D")
  end
  
  def self.find_first
    Stemplate.find(:first, :conditions => ["spot = ?", "D"])
  end
  
  def self.find_all
    Stemplate.find(:all, :conditions => [ "spot = ?", "D"])
  end
end