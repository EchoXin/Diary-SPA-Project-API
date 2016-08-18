class AddUserToDiaries < ActiveRecord::Migration
  def change
    add_reference :diaries, :user, index: true, foreign_key: true
  end
end
