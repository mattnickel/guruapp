class TotalNumberOfUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    total_users_count = User.count
	stats = Stat.new
	stats.event_stat = total_users_count
	stats.description = 'Total Number of Users'
	stats.created_at = Date.today
	stats.save

	#TotalNumberOfUsersJob.set(wait: 1.day).perform_later()
  end
end
