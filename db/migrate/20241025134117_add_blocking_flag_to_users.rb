class AddBlockingFlagToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :blocking_flag, :boolean, default: false, null: false
  end
end
