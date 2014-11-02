# CreateAddress
class CreateAddress < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :word

      t.timestamps
    end
  end
end
