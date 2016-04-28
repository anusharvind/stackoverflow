class Answer < ActiveRecord::Base

  belongs_to :user
  belongs_to :question
  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :content, presence: true, length: { maximum: 540 }
  default_scope -> { order(is_answer: :desc, votes: :desc, created_at: :desc) }
  has_many :comments, dependent: :destroy

end
