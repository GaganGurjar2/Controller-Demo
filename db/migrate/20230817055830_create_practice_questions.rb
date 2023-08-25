class CreatePracticeQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_questions do |t|
      t.text :question
      t.text :answer
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
