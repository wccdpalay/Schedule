class UserController < ApplicationController
  def view_week
    params[:user] ||= session[:user]

    @user = User.find(params[:user])
    @week = Week.find_by_woy_and_year(params[:woy].to_i, params[:year])  || Day.find_by_Date(Date.today).week

    @results = [[],[],[],[],[],[],[]]
    pos = 0
    for day in @week.days
      temp = []
      slots = day.slots.find_all_by_user_id(@user.id).sort {|x, y| x.start_time <=> y.start_time}
      slots.each {|x| temp << x.start_time}
      temp.reverse!
      st = temp.pop
      en = st
      while temp.length > 0
        if temp[length-1] == (en + 1)
          en = temp.pop
        else
          @results[pos] << [st, en]
          st = temp.pop
          en = st
        end
      end
      @results[pos] << [st, en]
      pos += 1
    end


  end

end
