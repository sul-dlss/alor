class AllowNullChannelTitle < ActiveRecord::Migration[8.0]
  def change
    change_column_null :channels, :title, true
  end
end
