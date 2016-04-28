class Question < ActiveRecord::Base
  
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 540 }
  default_scope -> { order(created_at: :desc) }
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy

  def answerfeed
    Answer.where("question_id = ?", id)
  end

end
