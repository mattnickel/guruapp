class TotalNumberOfNewSocialPostsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
	new_social_posts = SocialPost.where('created_at >= ?', 1.days.ago).count
	stats = Stat.new
	stats.event_stat = new_social_posts
	stats.description = 'Number of new social posts'
	stats.created_at = Date.today
	stats.save
	#TotalNumberOfSocialPostsJob.set(wait: 1.day).perform_later()
  end
end
