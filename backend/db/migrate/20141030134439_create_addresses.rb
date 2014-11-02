# CreateAddresses
class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :word
      t.string :address
    end
  end
end
