# In your schedule.rb file
every 1.month, at: 'start of the month', roles: [:app] do
  runner 'BonusPariJob.perform_now'
end
