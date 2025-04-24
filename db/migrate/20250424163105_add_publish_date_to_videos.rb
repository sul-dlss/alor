class AddPublishDateToVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :videos, :published_date, :datetime
  end
end
