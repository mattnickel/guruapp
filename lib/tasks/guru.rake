namespace :guru do
  desc 'Runs: TotalNumberOfUsersJob'
  task total_number_of_users: [:environment] do
    TotalNumberOfUsersJob.perform_now
  end
  
  desc 'Runs: TotalNumberOfUsersJob'
  task new_users: [:environment] do
    NewUsersJob.perform_now
  end
  
end