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

  let(:baggage_delay) { Coverage.create!(name: "Baggage Delay", description: "Covers delayed baggage.") }
  let(:emergency_medical) { Coverage.create!(name: "Emergency Medical", description: "Covers medical emergencies.") }
  let(:trip_cancellation) { Coverage.create!(name: "Trip Cancellation", description: "Covers trip cancellation.") }
  let(:additional_coverage) { Coverage.create!(name: "Additional Coverage", description: "Additional coverage type.") }

  before do
    # Create all coverages first
    [baggage_delay, emergency_medical, trip_cancellation, additional_coverage].each(&:save!)

    ProductQuote.create!(
      quote: quote,
      provider_name: "Cool Provider",
      product_name: "Neat Product",
      premium: 100.00,
      coverages: [baggage_delay, emergency_medical, trip_cancellation],
    )

    ProductQuote.create!(
      quote: quote,
      provider_name: "Another Provider",
      product_name: "Basic Product",
      premium: 50.00,
      coverages: [baggage_delay],
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
      expect(page).to have_content("Baggage Delay")
    end
  end

  it "lets customers view details about a coverage" do
    visit quote_path(quote)

    within(".product-quote-box") do
      click_link "Baggage Delay"
    end

    within(".js-coverage-modal") do
      expect(page).to have_content("Covers delayed baggage.")
    end
  end

  it "filters products based on selected coverages" do
    visit quote_path(quote)

    # Initially shows all products
    expect(page).to have_content("Neat Product")
    expect(page).to have_content("Basic Product")

    # Select Emergency Medical coverage
    check "Emergency Medical"

    # Only shows product with Emergency Medical coverage
    expect(page).to have_content("Neat Product")
    expect(page).not_to have_content("Basic Product")
  end

  it "recalculates premiums based on selected coverages" do
    visit quote_path(quote)

    # Check initial premium
    within(".product-quote-box", text: "Neat Product") do
      expect(page).to have_content("$100.00")
    end

    # Select Baggage Delay coverage
    check "Baggage Delay"

    # Premium should double
    within(".product-quote-box", text: "Neat Product") do
      expect(page).to have_content("$200.00")
    end

    # Select Emergency Medical coverage
    check "Emergency Medical"

    # Premium should add $50
    within(".product-quote-box", text: "Neat Product") do
      expect(page).to have_content("$250.00")
    end
  end

  it "persists coverage selections between page refreshes" do
    visit quote_path(quote)

    # Select some coverages
    check "Baggage Delay"
    check "Emergency Medical"

    # Refresh the page
    visit quote_path(quote)

    # Checkboxes should remain checked
    expect(page).to have_checked_field("Baggage Delay")
    expect(page).to have_checked_field("Emergency Medical")

    # Products should be filtered and premiums recalculated
    within(".product-quote-box", text: "Neat Product") do
      expect(page).to have_content("$250.00")
    end
  end

  it "shows a message when no products match selected coverages" do
    visit quote_path(quote)

    # Select a coverage that no product has
    check "Additional Coverage"

    # Should show the "no products" message
    expect(page).to have_content("No products match the selected coverages.")
  end
end
