#co = Checkout.new(pricing_rules)
#co.scan(item)
#co.scan(item)
#price = co.total

class Checkout

  attr_reader :basket

  def initialize(pricing_rules = [])
    @basket = []
    @rules  = pricing_rules
  end

  def scan(item)
    @basket << item if item
  end

  def total
    @total = 0
    items  = @basket.dup

    # Apply rules
    #@rules.each { |rule| @total += rule.apply!(items) }
    @rules.each do |rule|
      @total += rule.apply(items)
      items  = rule.clear!(items)
    end

    # If any item left
    items.each { |item| @total += PRODUCTS[item][:price] }

    raise 'negative?!' if @total < 0
    format_price @total
  end

  private

    def format_price(price)
      price_str = price.to_s
      price_str = '0' + price_str while price_str.length < 3
      length    = price_str.length
      "#{CURRENCY_SYMBOL}#{price_str[0..length-3]}.#{price_str[-2..length]}"
    end

end
