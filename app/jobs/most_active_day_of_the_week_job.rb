class MostActiveDayOfTheWeekJob < ApplicationJob
 queue_as :default

  def perform()
    # Do something later
    # most_active = Stat.where('created_at > ? and description = ?', Date.today-1.week, 'Number of active users')
    # .limit(1).order('active_count desc')
    # weekly_stats = WeeklyStat.new
    # weekly_stats.description = "Most active day of the week"
    # most_active.each do |row|
    #   weekly_stats.event_stat = row.day
    # end
    # weekly_stats.created_at = Date.today
    # weekly_stats.save

  end
end