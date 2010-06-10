class UserController < ApplicationController
  def view_week
    @title = "View Schedule for the Week"
    params[:user] ||= session[:user]

    @user = User.find(params[:user])
    @week = Week.find_by_woy_and_year(params[:woy].to_i, params[:year])  || Day.find_by_date(Date.today).week

    @prev = Week.find(@week.id-1) unless @week.id == 1
    @next = Week.find(@week.id+1) unless @week.id == Week.last.id

    @results = get_results(@user, @week)

  end

  def change_user
    vals = params[:value].split('**')
    params[:user] = vals[0]
    params[:week] = vals[1]
    @user = User.find(params[:user])
    @week = Week.find(params[:week])
    @results = get_results(@user, @week)

    respond_to do |format|
      format.html {redirect_to :action => "view_week", :woy => @week.woy, :year => @week.year, :user => @user}
      format.js  {}
    end
  end



  private
  def get_results(user, week)
    results = [[],[],[],[],[],[],[]]
    pos = 0
    for day in week.days
      temp = []
      slots = day.slots.find_all_by_user_id(user.id).sort {|x, y| x.start_time <=> y.start_time}
      slots.each {|x| temp << x.start_time}
      temp.reverse!
      st = temp.pop
      en = st
      while temp.length > 0
        if temp[temp.length-1] == (en + 1)
          en = temp.pop
        else
          results[pos] << [st, en]
          st = temp.pop
          en = st
        end
      end
      results[pos] << [st, en]
      pos += 1
    end
    results
  end
end
