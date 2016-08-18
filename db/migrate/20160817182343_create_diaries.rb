class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.string :title
      t.string :content

      t.timestamps null: false
    end
  end
end
