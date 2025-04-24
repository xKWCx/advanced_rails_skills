class ProductQuote < ApplicationRecord
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
    has_emergency_medical = coverage_names.include?("Emergency Medical")

    selected_coverages.each do |coverage|
      case coverage.name
      when "Baggage Delay"
        premium *= 2
      when "Emergency Medical"
        premium += 50
      when "Trip Cancellation"
        premium += has_emergency_medical ? 75 : 100
      end
    end

    premium
  end
end
