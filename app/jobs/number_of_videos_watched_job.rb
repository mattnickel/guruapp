require 'sendgrid-ruby'
#include SendGrid
class NumberOfVideosWatchedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    videos_viewed = Viewing.select('DISTINCT video_id')
    .where('viewings.created_at > ?', Date.today-1.week).count
	  weekly_stats = WeeklyStat.new
	  weekly_stats.event_stat = videos_viewed
	  weekly_stats.description = 'Number of videos watched this week'
	  weekly_stats.created_at = Date.today

	  wekly_stats.save

  end
end
