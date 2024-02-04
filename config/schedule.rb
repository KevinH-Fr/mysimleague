#every 1.day, at: 'start of the day', roles: [:app] do
#  runner 'BonusPariJob.perform_later'
#end

# config/schedule.rb

every 1.day, at: 'start of the day', roles: [:app] do
  rake 'my_tasks:enqueue_bonus_pari_job'
end
