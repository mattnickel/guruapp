class InactiveUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    inactive_users = UserActivity.where('active_count = 0').count
<<<<<<< HEAD
    stats = Stat.new
    stats.event_stat = inactive_users
    stats.description = 'Number of inactive users'
    stats.created_at = Date.today
    weekday = Date.today.strftime('%A') 
    stats.day = weekday
    stats.save
		
=======
		stats = Stat.new
		stats.event_stat = inactive_users
		stats.description = 'Number of inactive users'
		stats.created_at = Date.today
		weekday = Date.today.strftime('%A') 
		stats.day = weekday
		stats.save
>>>>>>> 209d3a524fbaa56a8995fe401f6fa2f66ff62557
	#InactiveUsersJob.set(wait: 1.day).perform_later()
  end
end
