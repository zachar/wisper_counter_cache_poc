class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :teams_counter, default: 0, null: false
      t.timestamps
    end
  end
end
