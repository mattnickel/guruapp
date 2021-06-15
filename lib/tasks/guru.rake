namespace :guru do
  desc 'Runs: TotalNumberOfUsersJob'
  task total_number_of_users: [:environment] do
    TotalNumberOfUsersJob.perform_now
  end
  
  desc 'Runs: TotalNumberOfUsersJob'
  task new_users: [:environment] do
    NewUsersJob.perform_now
  end

  desc 'Runs: Three most watched videos of the week'
  task three_most_watched_videos: [:environment] do
    ThreeMostWatchedVideosJob.perform_now
  end

  desc 'Runs: Weekly Report'
  task weekly_report: [:environment] do
    WeeklyReportJob.perform_now
  end

end