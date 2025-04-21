class AddVideoIdIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :videos, :video_id, unique: true
  end
end
