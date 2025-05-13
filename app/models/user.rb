class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :full_name, :role, presence: true
end
