class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.integer :votes
      t.boolean :is_answer

      t.timestamps null: false
    end
    add_index :answers, [:user_id, :question_id, :created_at]
  end
end
