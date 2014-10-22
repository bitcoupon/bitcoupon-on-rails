class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :create_private_key
      t.string :create_address

      t.string :return_private_key
      t.string :return_address

      t.timestamps
    end
  end
end
