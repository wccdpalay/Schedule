# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

#blank Day_Template
daytemplates = Dtemplate.create([{:name => "Blank"}, {:name => "Blank Fall/Winter Weekday"}])
wtemplate = Wtemplate.create({:name => "Empty Template"})



def get_workers

d = Day.find_by_date(Date.today)
#shift 1 level 2
for x in 11..22
  s = d.slotAs[x]
  s.user_id = USERS[:Carol]
  s.save!
end
#shift2 level2
for x in 23..40
 s = d.slotAs[x]
 s.user_id = USERS[:Dave]
 s.save!
end

#shift1 workstudy
for x in 11..15
  s = d.slotCs[x]
  s.user_id = USERS[:Reg]
  s.save!
end

#shift2 workstudy
for x in 13..18
s = d.slotDs[x]
s.user_id = USERS[:Mina]
s.save!
end

#shift3 workstudy
for x in 17..38
s = d.slotCs[x]
s.user_id = USERS[:Sarah]
s.save!
end
end


year = Date.today.year
  #def init_year(year)
puts "starting year #{year}"
#puts "making new date"
    date = Date.new(year, 1, 1)
#puts "check for leap year"
    unless date.leap?
      days = 365
    else
      days = 366
    end
#puts "#{days} in the year"

   woy = 1
   
  #check for what week to put it in
   #if the previous year was initialized
  if Week.find_by_year(year-1)
    #check if the last year ended on a friday
    unless Week.find_all_by_year(year-1).last.days.last.date.wday == 5 #unless friday
      #change week of year to be the previous week (the last week of the previous year)
      w = Week.find_all_by_year(year-1).last
    else #else we DID end on a friday, and the first day is a new week
      #puts "Making new week ##{woy}"
      w = Week.new({:year => year, :woy => woy})
    end
  else
  w = Week.new({:year => year, :woy => woy})
  end
  


    
    #find the start of the week
    start_sat = date
    while start_sat.wday < 6
     start_sat -= 1 
    end
      w.start_date = start_sat
    
    w.save!
puts "Week #{woy} saved with start_date = #{w.start_date}"
#puts "Making new day"
    d = Day.new({:date => date, :week => w, :being_edited => DateTime.now - 2.years})
    d.save!
puts "Saved #{d.date}"
    days -= 1
    
    while days > 0
          #If it's Friday, make a new week
      if d.date.wday == 5
        woy += 1
        w = Week.new({:year => year, :woy => woy, :start_date => d.date+1})
        w.save!
puts "Week #{woy} saved with start_date = #{w.start_date}"        
      end
      d = Day.new({:date => d.date.tomorrow, :week => w, :being_edited => DateTime.now - 2.years})
      d.save!
puts "Saved #{d.date}"
      days -= 1
    end