class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true, index: true
      t.references :product, foreign_key: true, index: true

      t.timestamps
    end
  end
end
