class CreateOutputs < ActiveRecord::Migration
  def change
    create_table :outputs do |t|
      # id implicit
      t.references :transaction
      t.string :creator_address
      t.text :payload
      t.integer :amount
      t.string :receiver_address
      t.references :input

      t.timestamps
    end
  end
end
