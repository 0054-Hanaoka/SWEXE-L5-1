class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :message
      t.integer :user_id, null: false  

      t.timestamps
    end

    # 外部キー制約を付ける（あると安全）
    add_foreign_key :profiles, :users
  end
end
