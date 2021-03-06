class ActiveUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    active_users = UserActivity.where('active_count > 0').count
    stats = Stat.new
    stats.event_stat = active_users
    stats.description = 'Number of active users'
    stats.created_at = Date.today
    weekday = Date.today.strftime('%A') 
    stats.day = weekday
    stats.save
		
    

    
	#ActiveUsersJob.set(wait: 1.day).perform_later()
  end
end
