class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.string :channel_id

      t.timestamps
    end
  end
end
