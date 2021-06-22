class NumberOfAttemptedSharesToSocialMediaJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    social_attempt = SocialAttempt.where('created_at > ?', Date.today-1.week).count
	  weekly_stats = WeeklyStat.new
	  weekly_stats.event_stat = social_attempt
	  weekly_stats.description = 'Number of attempted shares to social media this week'
	  weekly_stats.created_at = Date.today

	  weekly_stats.save
  end
end
