class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :uid
      t.string :deploy_uid
      t.string :user_uid
      t.text :body, null: false
      t.timestamps null: false
    end
  end
end
