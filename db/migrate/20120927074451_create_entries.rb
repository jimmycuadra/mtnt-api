class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.boolean :needs, null: false
      t.string :noun, null: false
      t.string :verb, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :entries, :user_id
  end
end
