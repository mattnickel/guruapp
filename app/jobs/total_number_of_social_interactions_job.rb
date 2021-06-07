class TotalNumberOfSocialInteractionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    new_comments_count = Comment.where('created_at >= ?', 1.days.ago).count
    new_bumps_count = PostBump.where('created_at >= ?', 1.days.ago).count
    total_interactions = new_comments_count + new_bumps_count
    
    stats = Stat.new
	  stats.event_stat = total_interactions
	  stats.description = 'Total Number of Interactions'
	  stats.created_at = Date.today
	  stats.save
	  #TotalNumberOfSocialInteractionsJob.set(wait: 1.day).perform_later()
  end
end
