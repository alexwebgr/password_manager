class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true, length: { in: 10..16 }
end
