class QuotesController < ApplicationController
  def index
    @quotes = Quote.all
  end

  def show
    @quote = Quote.find(params[:id])
  end

  def update_products
    @quote = Quote.find(params[:id])
    @selected_coverages = Coverage.where(id: params[:coverage_ids])

    # Get products that match all selected coverages
    @product_quotes = filter_products_by_coverages(@quote.product_quotes, @selected_coverages)

    # Update premiums based on selected coverages
    update_product_premiums(@product_quotes, @selected_coverages)

    respond_to do |format|
      format.js
    end
  end

  private

  # Returns products that have all the selected coverages
  def filter_products_by_coverages(products, selected_coverages)
    return products if selected_coverages.empty?

    products.select do |product|
      selected_coverages.all? { |coverage| product.coverages.include?(coverage) }
    end
  end

  # Updates the premium for each product based on selected coverages
  def update_product_premiums(products, selected_coverages)
    products.each do |product|
      product.premium = calculate_premium(product, selected_coverages)
    end
  end

  def calculate_premium(product_quote, selected_coverages)
    premium = product_quote.premium

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
