class AddWeatherToDiaries < ActiveRecord::Migration
  def change
    add_column :diaries, :weather, :string
  end
end
