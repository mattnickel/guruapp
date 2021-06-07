class ActiveUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    active_users = UserActivity.where('active_count > 0').count
	stats = Stat.new
	stats.event_stat = active_users
	stats.description = 'Number of active users'
	d = Date.today
	weekday = Date.parse( '#{d.day} #{d.month} #{d.year}' ).strftime('%A') 
	stats.day = weekday
	stats.save
	#AtiveUsersJob.set(wait: 1.day).perform_later()
  end
end
