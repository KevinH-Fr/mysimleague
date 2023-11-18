class DropActiveAnalyticsViewsPerDays < ActiveRecord::Migration[7.0]
  def change
    drop_table :active_analytics_views_per_days
  end
end
