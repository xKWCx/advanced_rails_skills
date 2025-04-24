require "rails_helper"

RSpec.describe "Viewing a quote", type: :feature do
  let(:quote) do
    Quote.create!(
      departure_date: Date.today,
      return_date: Date.tomorrow,
      destination_country: "Canada",
      trip_cost: 1234,
      travelers_count: 1,
    )
  end

  before do
    coverage = Coverage.create!(name: "Some Coverage", description: "Covers things.")

    ProductQuote.create!(
      quote: quote,
      provider_name: "Cool Provider",
      product_name: "Neat Product",
      premium: 12.34,
      coverages: [coverage],
    )
  end

  it "shows the customer information about their quote" do
    visit quote_path(quote)

    within(".my-quote-panel") do
      expect(page).to have_content("My Quote")
      expect(page).to have_content("Canada")
    end

    within(".product-quote-box") do
      expect(page).to have_content("Cool Provider")
      expect(page).to have_content("Some Coverage")
    end
  end

  it "lets customers view details about a coverage" do
    visit quote_path(quote)

    within(".product-quote-box") do
      click_link "Some Coverage"
    end

    within(".js-coverage-modal") do
      expect(page).to have_content("Covers things.")
    end
  end
end
