class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :uid
      t.references :deploy
      t.references :user
      t.text :body, null: false
      t.timestamps null: false
    end
  end
end
