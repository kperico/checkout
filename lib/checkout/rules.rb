module Rule

  module GreenTea

    @code = 'GR1'
    @one_free_each = 2

    def self.apply(items)
      n = items.select{|item| item == @code}.count
      (n / @one_free_each + n % @one_free_each) * PRODUCTS[@code][:price]
    end

    def self.clear!(items)
      items.delete @code
      items
    end

  end

  module Strawberries

    @code = 'SR1'
    @no_discount_amount = 2
    @price_if_more_than = 450

    def self.apply(items)
      n = items.select{|item| item == @code}.count
      return 0 if n == 0
      n <= @no_discount_amount ? n * PRODUCTS[@code][:price] : n * @price_if_more_than
    end

    def self.clear!(items)
      items.delete @code
      items
    end

  end

end