class ResetUserActivityJob < ApplicationJob
  queue_as :default

  def perform()
    	UserActivity.update_all active_count: 0
  end
end