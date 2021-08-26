class TotalNumberOfSocialInteractionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    new_comments_count = Comment.where("created_at >= :created_at and created_at < :end_date",
                                {created_at: Date.today-1, end_date: Date.today }).count
    new_bumps_count = PostBump.where("created_at >= :created_at and created_at < :end_date",
                              {created_at: Date.today-1, end_date: Date.today }).count
    total_interactions = new_comments_count + new_bumps_count
    
    stats = Stat.new
	  stats.event_stat = total_interactions
	  stats.description = 'Total Number of Interactions'
	  stats.created_at = Date.today
    weekday = Date.today.strftime('%A') 
    stats.day = weekday
    stats.save
	  #TotalNumberOfSocialInteractionsJob.set(wait: 1.day).perform_later()


    # total_interactions_weekly = Stat.where( description: "Total Number of Interactions",'created_at > ?', Date.today-1.week).count
    # weekly_stats = WeeklyStat.new
    # weekly_stats.event_stat = social_posts_weekly
    # weekly_stats.description = 'Number of new social posts this week'
    # weekly_stats.created_at = Date.today
    # weekly_stats.save


    
  end
end
