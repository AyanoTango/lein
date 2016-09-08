# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(:name_id => 'a.tango', :password => 'ayayayo', :name => '丹後　彩乃')
User.create(:name_id => 'm.hirata', :password => 'pass', :name => '平田　雅美')
User.create(:name_id => 'k.aoki', :password => 'pass', :name => '青木　桂人')

Comment.create(:comment => 'こんにちは', :user_id => 1, :room_id => 1)
Comment.create(:comment => 'おはよう', :user_id => 2, :room_id => 1)
Comment.create(:comment => 'おやすみ', :user_id => 1, :room_id => 1)

# Room.create(:room_name => '1')
# Room.create(:room_name => '2')
# Room.create(:room_name => '3')
#
# Relationship.create(:room_id => 1, :user_id => 1)
# Relationship.create(:room_id => 1, :user_id => 2)
# Relationship.create(:room_id => 2, :user_id => 1)
# Relationship.create(:room_id => 2, :user_id => 3)
# Relationship.create(:room_id => 3, :user_id => 2)
# Relationship.create(:room_id => 3, :user_id => 3)
