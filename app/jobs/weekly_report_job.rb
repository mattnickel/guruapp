class WeeklyReportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    

    #Total Users
    total_users_count_weekly = User.count
    weekly_stats = WeeklyStat.new
	  weekly_stats.event_stat = total_users_count_weekly
	  weekly_stats.description = 'Total Number of Users'
	  weekly_stats.created_at = Date.today
	  weekly_stats.save

    #New Users
    new_users_count_weekly = User.where('created_at >= ?', Date.today-1.week).count
    weekly_stats = WeeklyStat.new
	  weekly_stats.event_stat = new_users_count_weekly
	  weekly_stats.description = 'Number of new users this week'
	  weekly_stats.created_at = Date.today
	  weekly_stats.save

    #Active Users
    active_users_stat = UserActivity.where('active_count > 0 and created_at = ?', Date.today-1.week).count
    weekly_stats = WeeklyStat.new
    weekly_stats.event_stat = active_users_stat
    weekly_stats.description = 'Number of active users this week'
    weekly_stats.created_at = Date.today
    weekly_stats.save

    #Inactive Users
    inactive_users_this_week = UserActivity.where('active_count = 0 and created_at = ?', Date.today-1.week).count
    weekly_stats = WeeklyStat.new
    weekly_stats.event_stat = inactive_users_this_week
    weekly_stats.description = 'Number of inactive users this week'
    weekly_stats.created_at = Date.today
    weekly_stats.save

    #Social Posts
    new_social_posts_weekly = SocialPost.where('created_at > ?', Date.today-1.week).count
    weekly_stats = WeeklyStat.new
    weekly_stats.event_stat = new_social_posts_weekly
    weekly_stats.description = 'Social Posts'
    weekly_stats.created_at = Date.today
    weekly_stats.save

    #Social Interactions
    total_social_interactions_weekly = Stat.where(["description = :description and created_at = :created_at", { description:"Total Number of Interactions", created_at: Date.today-1.week }]).count
    weekly_stats = WeeklyStat.new
    weekly_stats.event_stat = total_social_interactions_weekly
    weekly_stats.description = 'Social Interactions'
    weekly_stats.created_at = Date.today
    weekly_stats.save
   

    #Social Attempts or External Shares
    social_attempt_weekly = SocialAttempt.where('created_at > ?', Date.today-1.week).count
	  weekly_stats = WeeklyStat.new
	  weekly_stats.event_stat = social_attempt_weekly
	  weekly_stats.description = 'External Shares'
	  weekly_stats.created_at = Date.today
	  weekly_stats.save

    #Report Message Compostition
    stats_weekly = WeeklyStat.where('created_at > ?', Date.today-1.week)
    message = "<ol>"
    stats_weekly.each do |wstat|
      stat_desc = wstat.description
      stat_event = wstat.event_stat
      message += "<li> #{stat_desc} :   #{stat_event} </li> </br>"
	  end
    message += "</ol>"

    
    #Call UserMailer
    subject = "Weekly Report for #{Date.today-1.week} to #{Date.today}"       
    UserMailer.report_message(subject,message).deliver
    
         
 	  #WeeklyReportJob.set(wait: 1.week).perform_later()
    
    # Stat.select('stats.*, SUM(event_stat.to_i) AS total_events').where(['description = :description and created_at = :created_at', { description: 'Number of active users' , created_at: Date.today-1.week }]).sum(:event_stat)
    # = User.joins(:predictions)
    # .where("fixture_date <= ?", Date.today)
    # .select('stats.*, SUM(event_stat.to_i) AS total_events')
    
    
    # Stat.select("sum(event_stat)").where(['description = :description and created_at = :created_at', { description: 'Number of active users' , created_at: Date.today-1.week }])

    # Stat.select("sum(event_stat) AS total_stat_event").where(['description = :description and created_at = :created_at', { description: 'Number of active users' , created_at: Date.today-1.week }])
    # weekly_stats = WeeklyStat.new
    #where('description = "Total Number of Interactions" and created_at = ?', Date.today-1.week')
    


    #(['active_count > 0','created_at = ?'], Date.today-1.week).count
  end
end
