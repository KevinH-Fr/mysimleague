every 1.day, at: 'start of the day', roles: [:app] do
  runner 'BonusPariJob.perform_later'
end