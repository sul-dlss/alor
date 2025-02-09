class CreateVideos < ActiveRecord::Migration[8.0]
  def change
    create_table :videos do |t|
      t.string :video_id
      t.string :title
      t.timestamp :refresh_job_started_at

      t.timestamps
    end
  end
end
