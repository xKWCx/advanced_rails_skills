class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.date "departure_date"
      t.date "return_date"
      t.string "destination_country"
      t.integer "trip_cost"
      t.integer "travelers_count"

      t.timestamps
    end
  end
end
