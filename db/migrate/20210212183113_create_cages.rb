class CreateCages < ActiveRecord::Migration[5.2]
  def change
    create_table :cages do |t|
      t.integer :max_capacity, default: 0
      t.integer :current_occupancy, default: 0
      t.boolean :active, default: true
      t.string :created_by

      t.timestamps
    end
  end
end
