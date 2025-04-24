random = Random.new(1234)
Faker::Config.random = random

coverages = [
  Coverage.create!(name: "Baggage Delay", description: "Baggage Delay provides reimbursement for the purchase of clothing, toiletries, and other essential items if a traveler’s luggage is delayed for a specified period of time."),
  Coverage.create!(name: "Emergency Medical", description: "Emergency Medical can reimburse the costs to treat a medical emergency during a trip."),
  Coverage.create!(name: "Trip Cancellation", description: "Trip Cancellation provides reimbursement for prepaid and non-refundable trip payments if a trip is canceled due to unforeseen circumstances, including illness, injury, or death."),
]

10.times do
  quote = Quote.create!(
    departure_date: Faker::Date.backward(days: 14),
    return_date: Faker::Date.forward(days: 14),
    destination_country: Faker::Address.country,
    trip_cost: random.rand(100..9999),
    travelers_count: random.rand(1..4),
  )

  random.rand(3..9).times do
    product_name = %w{Trip Travel Flight Adventure Cruise Trek Voyage}.sample(random: random)
    product_name << " "
    product_name << %w{Bronze Silver Gold Platinum Basic Economy Luxury Preferred}.sample(random: random)

    ProductQuote.create!(
      quote: quote,
      provider_name: "#{Faker::Company.name} #{Faker::Company.suffix}",
      product_name: product_name,
      premium: Faker::Number.between(from: 5.0, to: 999.99).round(2),
      coverages: coverages.sample(random.rand(1..3), random: random).sort_by(&:name),
    )
  end
end
