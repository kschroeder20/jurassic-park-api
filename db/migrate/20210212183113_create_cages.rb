class CreateCages < ActiveRecord::Migration[5.2]
  def change
    create_table :cages do |t|
      t.integer :max_capacity, default: 0
      t.integer :current_capacity, default: 0
      t.boolean :power, default: false
      t.string :created_by

      t.timestamps
    end
  end
end
