class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.reference :owner, index: true
      t.string :name
      t.text :description
      t.integer :beds
      t.float :baths
      t.integer :rent

      t.timestamps
    end
  end
end
