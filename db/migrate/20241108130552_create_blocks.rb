class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.references :blocker, null: false, foreign_key: { to_table: :users } #referencesで外部キー設定。user_idが外部キー
      t.references :blocked, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
