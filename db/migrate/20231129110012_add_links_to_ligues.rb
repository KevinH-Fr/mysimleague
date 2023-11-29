class AddLinksToLigues < ActiveRecord::Migration[7.0]
  def change
    add_column :ligues, :discord, :string
    add_column :ligues, :instagram, :string
    add_column :ligues, :tiktok, :string
    add_column :ligues, :twitch, :string
    add_column :ligues, :youtube, :string
    add_column :ligues, :twitter, :string

  end
end
