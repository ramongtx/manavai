class AddBasicCardModel < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :mtg_id, unique: true, null: false

      t.string :name, null: false, index: true
      t.json :colors
      t.json :names
      t.json :color_identity
      t.json :printings
      t.string :mana_cost
      t.string :type
      t.string :rarity
      t.string :set
      t.string :text
      t.string :power
      t.string :toughness
      t.string :multiverse_id
      t.string :image_url

      t.string :portuguese_mid
      t.string :portuguese_name


      t.timestamps
    end
  end
end
