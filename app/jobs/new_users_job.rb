class NewUsersJob < ApplicationJob
  queue_as :default


  def perform(*args)
    # Do something later
	new_users_count = User.where('created_at >= ?', 1.days.ago).count
	stats = Stat.new
	stats.event_stat = new_users_count
	stats.description = 'New users'
	stats.created_at = Date.today
  weekday = Date.today.strftime('%A') 
  stats.day = weekday
  stats.save

	#NewUsersJob.set(wait: 1.day).perform_later()
  end
end
