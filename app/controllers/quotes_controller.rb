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

    # Filter products that have all selected coverages
    @product_quotes = @quote.product_quotes.select do |pq|
      @selected_coverages.all? { |coverage| pq.coverages.include?(coverage) }
    end

    # Recalculate premiums based on selected coverages
    @product_quotes.each do |pq|
      pq.premium = calculate_premium(pq, @selected_coverages)
    end

    respond_to do |format|
      format.js
    end
  end

  private

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
