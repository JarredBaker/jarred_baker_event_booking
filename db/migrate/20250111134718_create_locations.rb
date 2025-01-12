class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations, id: :uuid do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :locatable, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
