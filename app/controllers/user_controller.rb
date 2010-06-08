class UserController < ApplicationController
  def view_week
    @user = params[:user] ||= session[:user]
    @week = params[:woy].to_i || Date.today.strftime('%V').to_i

    @results = {}
    @results[:sat] = []
    @results[:sun] = []
    @results[:mon] = []
    @results[:tue] = []
    @results[:wed] = []
    @results[:thu] = []
    @results[:fri] = []
    for day in @week.days
      temp = []
      slots = day.slots.find_all_by_user_id(@user).sort {|x, y| x.start_time <=> y.start_time}
      slots.each {|x| temp << x.start_time}
      temp.reverse!
      st = temp.pop
      en = st
      while temp.length > 0
        if temp[length-1] == (en + 1)
          en = temp.pop
        else
          results[day.name] << [st, en]
          st = temp.pop
          en = st
        end
      end
      @results[day.name] << [st, en]
    end


  end

end
