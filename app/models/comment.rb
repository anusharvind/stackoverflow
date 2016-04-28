class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  belongs_to :answer
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 540 }
  default_scope -> { order(created_at: :desc) }
end
