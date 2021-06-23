class WeeklyReportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    stats_weekly = WeeklyStat.where('created_at > ?', Date.today-1.week)
    stats_weekly.each do |wstat|
      subject = wstat.description
      message = wstat.event_stat
      UserMailer.report_message(subject,message).deliver      
	  end	

	  #WeeklyReportJob.set(wait: 1.week).perform_later()
  end
end
