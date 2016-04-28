class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.integer :votes

      t.timestamps null: false
    end
    add_index :questions, [:user_id, :created_at]
  end
end
