class ProductQuote < ApplicationRecord
  belongs_to :quote
  has_and_belongs_to_many :coverages
end
