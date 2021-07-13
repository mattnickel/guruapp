namespace :guru do

  desc 'Runs: Number of Active Users'
  task active_users: [:environment] do
    ActiveUsersJob.perform_now
  end

  desc 'Runs: Number of Inactive Users'
  task inactive_users: [:environment] do
    InactiveUsersJob.perform_now
  end
  

  desc 'Runs: Number of New Users'
  task new_users: [:environment] do
    NewUsersJob.perform_now
  end

  desc 'Runs: Number of Attempted Shares to Social Media'
  task number_of_attempted_shares_to_social_media: [:environment] do
    NumberOfAttemptedSharesToSocialMediaJob.perform_now
  end

  #DO NUT RUN
  desc 'Runs: Reset User Activity'
  task reset_user_activity: [:environment] do
    ResetUserActivityJob.perform_now
  end


  desc 'Runs: Total Number Of New Social Posts'
  task total_number_of_new_social_posts: [:environment] do
    TotalNumberOfNewSocialPostsJob.perform_now
  end

  desc 'Runs: Total Number Of Social Interactions'
  task total_number_of_social_interactions: [:environment] do
    TotalNumberOfSocialInteractionsJob.perform_now
  end

  desc 'Runs: Total Number Of Users'
  task total_number_of_users: [:environment] do
    TotalNumberOfUsersJob.perform_now
  end

  
  desc 'Runs: Weekly Report'
  #Runs weekly stats
  task weekly_report: [:environment] do
    WeeklyReportJob.perform_now
  # Will run every Saturday
    # if Date.today.wday == 6 
    #   WeeklyReportJob.perform_now
    # end 
  end


  #Weekly
  # desc 'Runs: Most Active Day of the Week'
  # task most_active_day_of_the_week: [:environment] do
  #   MostActiveDayOfTheWeekJob.perform_now
  #   # Will run every Saturday
  #   #   if Date.today.wday == 6 
  #   #     MostActiveDayOfTheWeekJob.perform_now
  # end

  #Weekly
  # desc 'Runs: Three most watched videos of the week'
  # task three_most_watched_videos: [:environment] do
  #   ThreeMostWatchedVideosJob.perform_now  
  #   # Will run every Saturday
  #   #  if Date.today.wday == 6 
  #   #    ThreeMostWatchedVideosJob.perform_now
  # end

  #Weekly
  # desc 'Runs: Number Of Videos Watched Job'
  # task number_of_videos_watched: [:environment] do
  #   NumberOfVideosWatchedJob.perform_now
  #   # Will run every Saturday
  #   #  if Date.today.wday == 6 
  #   #    NumberOfVideosWatchedJob.perform_now
  # end
end