class CreateRentModel < ActiveRecord::Migration[5.2]
  def change
    create_table :rents do |t|
      t.references :user,      null: false
      t.references :book,      null: false
      t.date :from,            null: false
      t.date :to,              null: false
      t.timestamps
    end
  end
end
