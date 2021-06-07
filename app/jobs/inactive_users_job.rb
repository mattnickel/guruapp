class InactiveUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    inactive_users = UserActivity.where('active_count = 0').count
	stats = Stat.new
	stats.event_stat = inactive_users
	stats.description = 'Number of inactive users'
	stats.created_at = Date.today
	d = Date.today
	weekday = Date.parse( '#{d.day} #{d.month} #{d.year}' ).strftime('%A') 
	stats.day = weekday
	stats.save
	#InactiveUsersJob.set(wait: 1.day).perform_later()
  end
end
