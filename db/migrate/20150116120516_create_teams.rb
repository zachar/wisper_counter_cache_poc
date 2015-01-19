class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :players_counter, default: 0, null: false
      t.timestamps
    end
  end
end
