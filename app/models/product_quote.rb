class ProductQuote < ApplicationRecord
  # Coverage types
  BAGGAGE_DELAY = "Baggage Delay"
  EMERGENCY_MEDICAL = "Emergency Medical"
  TRIP_CANCELLATION = "Trip Cancellation"

  # Premium adjustments
  BAGGAGE_DELAY_MULTIPLIER = 2
  EMERGENCY_MEDICAL_ADDITION = 50
  TRIP_CANCELLATION_WITH_EM = 75
  TRIP_CANCELLATION_WITHOUT_EM = 100

  belongs_to :quote
  has_and_belongs_to_many :coverages

  def self.filter_by_coverages(products, selected_coverages)
    return products if selected_coverages.empty?

    # Preload coverages to avoid N+1 queries
    products = products.includes(:coverages)

    # Convert to arrays to avoid N+1 queries
    selected_coverage_ids = selected_coverages.map(&:id)

    products.select do |product|
      product_coverage_ids = product.coverages.map(&:id)
      selected_coverage_ids.all? { |id| product_coverage_ids.include?(id) }
    end
  end

  def update_premium_based_on_coverages(selected_coverages)
    self.premium = calculate_premium(selected_coverages)
  end

  private

  def calculate_premium(selected_coverages)
    premium = self.premium

    # Pre-calculate coverage names to avoid repeated lookups
    coverage_names = selected_coverages.map(&:name)
    has_emergency_medical = coverage_names.include?(InsuranceCoverage::EMERGENCY_MEDICAL)

    selected_coverages.each do |coverage|
      rule = InsurancePremium::RULES[coverage.name]
      next unless rule

      premium = if coverage.name == InsuranceCoverage::TRIP_CANCELLATION
                  rule.call(premium, has_emergency_medical)
                else
                  rule.call(premium)
                end
    end

    premium
  end
end
