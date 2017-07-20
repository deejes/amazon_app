class Addusertoproduct < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews , :user, foreign_key: true, index: true
    add_reference :products , :user, foreign_key: true, index: true
  end
end
