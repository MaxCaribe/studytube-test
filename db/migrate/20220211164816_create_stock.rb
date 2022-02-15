class CreateStock < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :name
      t.index :name, unique: true

      t.belongs_to :bearer

      t.timestamps
    end
  end
end
