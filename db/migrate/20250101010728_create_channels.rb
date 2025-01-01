class CreateChannels < ActiveRecord::Migration[8.0]
  def change
    create_table :channels do |t|
      t.string :channel_id, null: false
      t.string :title, null: false
      t.timestamp :refresh_job_started_at

      t.timestamps
    end
  end
end
