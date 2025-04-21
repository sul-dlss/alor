class AddChannelIdIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :channels, :channel_id, unique: true
  end
end
