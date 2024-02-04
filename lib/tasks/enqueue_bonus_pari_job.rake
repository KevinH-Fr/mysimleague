# lib/tasks/enqueue_bonus_pari_job.rake

namespace :my_tasks do
    task :enqueue_bonus_pari_job => :environment do
      BonusPariJob.perform_later
    end
  end
  