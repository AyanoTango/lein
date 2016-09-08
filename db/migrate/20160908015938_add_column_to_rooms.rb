class AddColumnToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :room_name, :string
    remove_column :rooms, :user_id1, :string
    remove_column :rooms, :user_id2, :string
  end
end
