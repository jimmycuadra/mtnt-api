class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :api_key, null: false
      t.boolean :admin, default: false

      t.timestamps
    end

    add_index :users, :api_key
  end
end
