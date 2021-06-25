class WelcomeController < ApplicationController
	
  def index
    WeeklyReportJob.perform_now
  end
  def download
  end
  def privacy
  end
end
