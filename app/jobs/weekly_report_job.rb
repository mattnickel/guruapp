class WeeklyReportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    stats_weekly = WeeklyStat.where('created_at > ?', Date.today-1.week)
    message = ""
    stats_weekly.each do |wstat|
      message += wstat.description + " #" + wstat.event_stat
	  end
    subject = "Weekly Report for #{Date.today-1.week} to #{Date.today}"
    UserMailer.report_message(subject,message).deliver

	  #WeeklyReportJob.set(wait: 1.week).perform_later()
  end
end
