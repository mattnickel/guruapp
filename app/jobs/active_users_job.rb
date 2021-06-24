class ActiveUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    active_users = UserActivity.where('active_count > 0').count
<<<<<<< HEAD
    stats = Stat.new
    stats.event_stat = active_users
    stats.description = 'Number of active users'
    weekday = Date.today.strftime('%A') 
    stats.day = weekday
    stats.save
		
=======
	  stats = Stat.new
	  stats.event_stat = active_users
	  stats.description = 'Number of active users'
  	weekday = Date.today.strftime('%A') 
	  stats.day = weekday
	  stats.save
>>>>>>> 209d3a524fbaa56a8995fe401f6fa2f66ff62557
	#AtiveUsersJob.set(wait: 1.day).perform_later()
  end
end
