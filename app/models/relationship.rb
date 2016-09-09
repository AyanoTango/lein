class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :room_id, :uniqueness => {:scope => :user_id}
  validates :user_id, presence: true
end
