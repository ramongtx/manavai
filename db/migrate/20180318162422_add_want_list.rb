class AddWantList < ActiveRecord::Migration[5.1]
  def change
    create_table :want_lists do |t|
      t.references :user, index: true, null: false
      t.references :card, index: true, null: false
      t.index %i[user_id card_id], unique: true

      t.timestamps
    end

    create_table :have_lists do |t|
      t.references :user, index: true, null: false
      t.references :card, index: true, null: false
      t.index %i[user_id card_id], unique: true

      t.timestamps
    end
  end
end
