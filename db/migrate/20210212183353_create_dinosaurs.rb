class CreateDinosaurs < ActiveRecord::Migration[5.2]
  def change
    create_table :dinosaurs do |t|
      t.string :name
      t.string :species
      t.boolean :is_carnivor, default: false
      t.string :created_by
      t.belongs_to :cage, index: true, foreign_key: true

      t.timestamps
    end
  end
end
