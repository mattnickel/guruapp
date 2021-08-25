class ActiveUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    active_users = UserActivity.select(:user_id)
    .where("active_count > :active_count and created_at >= :created_at and created_at < :end_date",
    {active_count: 0, created_at: Date.today-1, end_date: Date.today}).uniq.count
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
