class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :subject_id
      t.string :name, null: false

      t.timestamps
    end

    add_index :topics, :subject_id
  end
end
