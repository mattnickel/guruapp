class WeeklyReportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    #calculates weekly stats from Sunday to Saturday of the week
    today = Date.today
    #sunday start of last week 
    start_of_last_week =  today.last_week+6.days
    #saturday end of week last week
    end_of_last_week = today.last_week+12.days 
    #When report is ran on Sunday
    next_start_day = today.last_week+7.days
    next_end_day = today.last_week+13.days 

    #Total Users
    total_users_count_weekly = User.where("created_at <= :created_at",
                                   {created_at: end_of_last_week}).count
    weekly_stats = WeeklyStat.new
	  weekly_stats.event_stat = total_users_count_weekly
	  weekly_stats.description = "Total Number of Users"
	  weekly_stats.created_at = today
	  weekly_stats.save


    #New Users
    new_users_count_weekly = User.where("created_at >= :start_date AND created_at <= :end_date",
                                 {start_date: start_of_last_week, end_date: end_of_last_week}).count
    weekly_stats = WeeklyStat.new
	  weekly_stats.event_stat = new_users_count_weekly
	  weekly_stats.description = "Number of new users this week"
	  weekly_stats.created_at = today
	  weekly_stats.save


    #Active Users
    active_users_stat = UserActivity.select(:user_id)
                                    .where(["active_count > :active_count AND created_at >= :start_date AND created_at <= :end_date",
                                    {active_count: 0, start_date: start_of_last_week, end_date: end_of_last_week}]).uniq.count
    weekly_stats = WeeklyStat.new
    weekly_stats.event_stat = active_users_stat
    weekly_stats.description = "Number of active users this week"
    weekly_stats.created_at = today
    weekly_stats.save

    
    #Inactive Users
    inactive_users_this_week = total_users_count_weekly - active_users_stat
    # UserActivity.select(:user_id)
    # .where(["created_at < :created_at",
    # {created_at: Date.today-1.week }]).uniq.count
    weekly_stats = WeeklyStat.new
    weekly_stats.event_stat = inactive_users_this_week
    weekly_stats.description = "Number of inactive users this week"
    weekly_stats.created_at = today
    weekly_stats.save


    #Number of videos watched this week
    videos_viewed = Viewing.select("DISTINCT video_id")
                           .where("viewings.created_at >= :start_date AND viewings.created_at <= :end_date",
                           {start_date: start_of_last_week, end_date: end_of_last_week}).count
	  weekly_stats = WeeklyStat.new
	  weekly_stats.event_stat = videos_viewed
	  weekly_stats.description = "Number of videos watched this week"
	  weekly_stats.created_at = today
	  weekly_stats.save


    #Three most watched videos this week
    videos_watched = Viewing.joins("INNER JOIN videos ON videos.id = viewings.video_id")
                            .select("videos.title, SUM(viewings.last_second_viewed) AS time_viewed")
                            .where("viewings.created_at >= :start_date AND viewings.created_at <= :end_date",
                            {start_date: start_of_last_week, end_date: end_of_last_week})
                            .group("videos.title")
                            .order("SUM(viewings.last_second_viewed) desc limit 3")
    videos =[]
    videos_watched.each do |row|
    	videos << row.title
	  end
    weekly_stats = WeeklyStat.new
    weekly_stats.event_stat = videos.join(", ")
    weekly_stats.description = "Top 3 most watched videos of the week"
    weekly_stats.created_at = today
    weekly_stats.save


    #Most Active Day  of the Week
    most_active = Stat.where("created_at >= :start_date AND created_at <= :end_date AND description = :description",
    {start_date: next_start_day, end_date: next_end_day, description:"Number of active users"})
    .limit(1).order("CAST(event_stat AS int) desc , created_at desc")

    weekly_stats = WeeklyStat.new
    weekly_stats.description = "Most active day of the week"
    most_active.each do |row|
    record_date = Date.parse(row.day).wday
    actual_date_int = record_date-1
    weekly_stats.event_stat = Date::DAYNAMES[actual_date_int]
    end
    weekly_stats.created_at = today
    weekly_stats.save


    #Social Posts
    new_social_posts_weekly = SocialPost.where("created_at >= :start_date AND created_at <= :end_date",
                                        {start_date: start_of_last_week, end_date: end_of_last_week}).count
    weekly_stats = WeeklyStat.new
    weekly_stats.event_stat = new_social_posts_weekly
    weekly_stats.description = "Social Posts"
    weekly_stats.created_at = today
    weekly_stats.save


    #Social Interactions
    total_social_interactions_weekly = Stat.where("created_at >= :start_date AND created_at <= :end_date AND description = :description",
                                           {start_date: next_start_day, end_date: next_end_day, description:"Total Number of Interactions"})
                                           .sum('CAST(event_stat AS int)')
                                      
    weekly_stats = WeeklyStat.new
    weekly_stats.event_stat = total_social_interactions_weekly
    weekly_stats.description = "Social Interactions"
    weekly_stats.created_at = today
    weekly_stats.save
   
    

    #Social Attempts or External Shares
    social_attempt_weekly = SocialAttempt.where("created_at >= :start_date AND created_at <= :end_date",
                                          {start_date: start_of_last_week, end_date: end_of_last_week}).count
	  weekly_stats = WeeklyStat.new
	  weekly_stats.event_stat = social_attempt_weekly
	  weekly_stats.description = "External Shares"
	  weekly_stats.created_at = today
	  weekly_stats.save


    #Report Message Compostition
    stats_weekly = WeeklyStat.where("created_at = :start_date",{start_date: today})
    message = "<ol>"
    stats_weekly.each do |wstat|
      stat_desc = wstat.description
      stat_event = wstat.event_stat
      message += "<li style='font-size: 14px'> #{stat_desc} : #{stat_event} </li>"
	  end
    message += "</ol>"



    #Call UserMailer
    subject = "Weekly Report for #{start_of_last_week} to #{end_of_last_week}"       
    UserMailer.report_message(subject,message).deliver
    
         
 	  #WeeklyReportJob.set(wait: 1.week).perform_later()
    
    
  end
end
