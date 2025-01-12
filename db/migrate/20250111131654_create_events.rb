class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events, id: :uuid do |t|
      t.string :name, null: false, index: true
      t.text :description
      t.datetime :date, null: false, index: true
      t.integer :tickets_available, default: 0, null: false
      t.references :user, foreign_key: true, null: false, type: :uuid

      t.timestamps
    end

    add_index :events, [:user_id, :date]
  end
end
