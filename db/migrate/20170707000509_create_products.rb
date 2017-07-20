class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.text :title
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
