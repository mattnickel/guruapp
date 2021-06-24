class ThreeMostWatchedVideosJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    videos_watched = Viewing.joins("INNER JOIN videos ON videos.id = viewings.video_id")
    .select('videos.title, SUM(viewings.last_second_viewed) AS time_viewed')
    .where('viewings.created_at > ?', Date.today-1.week)
    .group('videos.title')
    .order('SUM(viewings.last_second_viewed) desc limit 3')
    videos =[]
    videos_watched.each do |row|
    	videos << row.title
	  end
<<<<<<< HEAD
    weekly_stats = WeeklyStat.new
    weekly_stats.event_stat = videos.join(",")
    weekly_stats.description = 'Top 3 most watched videos of the week'
    weekly_stats.created_at = Date.today
    weekly_stats.save
=======
	weekly_stats = WeeklyStat.new
	weekly_stats.event_stat = videos.join(",")
	weekly_stats.description = 'Top 3 most watched videos of the week'
	weekly_stats.created_at = Date.today
	weekly_stats.save
>>>>>>> 209d3a524fbaa56a8995fe401f6fa2f66ff62557
  end
end
