class AddCaptionDataToVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :videos, :caption_data, :jsonb, default: {}
  end
end
