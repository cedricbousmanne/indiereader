class AddLastStateStringToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_state_string, :string
    add_index :users, :last_state_string, unique: true
  end
end
