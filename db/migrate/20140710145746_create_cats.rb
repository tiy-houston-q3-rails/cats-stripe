class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.string :photo
      t.string :gender
      t.string :color

      t.timestamps
    end
  end
end
