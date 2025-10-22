class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :password_digest
      t.integer :age

      t.timestamps
    end
  end
end
