class ProductQuote < ApplicationRecord
  belongs_to :quote
  has_and_belongs_to_many :coverages

  def self.filter_by_coverages(products, selected_coverages)
    return products if selected_coverages.empty?

    products.select do |product|
      selected_coverages.all? { |coverage| product.coverages.include?(coverage) }
    end
  end

  def update_premium_based_on_coverages(selected_coverages)
    self.premium = calculate_premium(selected_coverages)
  end

  private

  def calculate_premium(selected_coverages)
    premium = self.premium

    selected_coverages.each do |coverage|
      case coverage.name
      when "Baggage Delay"
        premium *= 2
      when "Emergency Medical"
        premium += 50
      when "Trip Cancellation"
        if selected_coverages.any? { |c| c.name == "Emergency Medical" }
          premium += 75
        else
          premium += 100
        end
      end
    end

    premium
  end
end
