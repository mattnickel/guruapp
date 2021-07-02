class NumberOfAttemptedSharesToSocialMediaJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    
    social_attempt = SocialAttempt.where('created_at >= ?', 1.days.ago).count
	  stats = Stat.new
	  stats.event_stat = social_attempt
	  stats.description = 'Number of attempted shares'
	  stats.created_at = Date.today
		weekday = Date.today.strftime('%A') 
		stats.day = weekday
		stats.save
		

		# social_attempt_weekly = SocialAttempt.where('created_at > ?', Date.today-1.week).count
	  # weekly_stats = WeeklyStat.new
	  # weekly_stats.event_stat = social_attempt_weekly
	  # weekly_stats.description = 'Number of attempted shares to social media this week'
	  # weekly_stats.created_at = Date.today
	  # weekly_stats.save

  end
end
