class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.integer :objective_id
      t.integer :difficulty, default: Question::Difficulty::LOW
      t.integer :solution_type
      t.text :hint

      t.timestamps
    end

    add_index :questions, [:objective_id, :difficulty]
  end
end