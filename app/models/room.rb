class Room < ApplicationRecord
  has_many :relationship
  has_many :comment
end
