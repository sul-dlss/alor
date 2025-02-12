class AddDataToChannelsAndVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :channels, :data, :jsonb, default: {}
    add_column :videos, :data, :jsonb, default: {}
  end
end
