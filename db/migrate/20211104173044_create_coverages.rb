class CreateCoverages < ActiveRecord::Migration[5.2]
  def change
    create_table :coverages do |t|
      t.string "name"
      t.string "description"

      t.timestamps
    end
  end
end
