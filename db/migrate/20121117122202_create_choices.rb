class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :question_id, null: false
      t.text :value
      t.boolean :correct
      t.text :reason
      t.integer :order

      t.timestamps
    end

    add_index :choices, :question_id
  end
end
