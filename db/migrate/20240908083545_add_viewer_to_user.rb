class AddViewerToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :viewer, :boolean, default: false
  end
end
