class Task < ApplicationRecord
  belongs_to :user

  validates :title, :status, :user_id, presence: true
end
