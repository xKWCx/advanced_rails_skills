class CreateProductQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_quotes do |t|
      t.references "quote"

      t.string "provider_name"
      t.string "product_name"
      t.decimal "premium"

      t.timestamps
    end
  end
end
