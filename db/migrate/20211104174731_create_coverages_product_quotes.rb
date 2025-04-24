class CreateCoveragesProductQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :coverages_product_quotes do |t|
      t.references "coverage"
      t.references "product_quote"

      t.timestamps
    end
  end
end
