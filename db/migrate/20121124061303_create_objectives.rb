class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.integer :topic_id
      t.string :name, null: false
      t.string :grade

      t.timestamps
    end

    add_index :objectives, [:topic_id, :grade]
  end
end
