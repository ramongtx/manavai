class AddBasicCardModel < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :name, null: false, index: true, unique: true
      t.json :colors
      t.json :names
      t.json :color_identity
      t.json :printings, default: []
      t.string :mana_cost
      t.string :type
      t.string :rarity
      t.string :text
      t.string :power
      t.string :toughness
      t.string :portuguese_name

      t.timestamps
    end
  end
end
