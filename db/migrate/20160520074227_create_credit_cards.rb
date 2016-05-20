class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :user_id
      t.string :token
      t.string :brand
      t.string :last4
      t.string :fingerprint
      t.timestamps null: false
    end
  end
end
