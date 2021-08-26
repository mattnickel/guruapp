class TotalNumberOfNewSocialPostsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
	new_social_posts = SocialPost.where("created_at >= :created_at and created_at < :end_date",
														  	{created_at: Date.today-1, end_date: Date.today }).count
	stats = Stat.new
	stats.event_stat = new_social_posts
	stats.description = 'Number of new social posts'
	stats.created_at = Date.today
	weekday = Date.today.strftime('%A') 
	stats.day = weekday
	stats.save
	#TotalNumberOfSocialPostsJob.set(wait: 1.day).perform_later()

	# new_social_posts_weekly = SocialPost.where('created_at > ?', Date.today-1.week).count
	# weekly_stats = WeeklyStat.new
	# weekly_stats.event_stat = social_posts_weekly
	# weekly_stats.description = 'Number of new social posts this week'
	# weekly_stats.created_at = Date.today
	# weekly_stats.save
  



 end
end
