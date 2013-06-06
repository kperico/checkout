require 'spec_helper'

describe Checkout do

  it "will have an empty basket when instantiated" do
    checkout = Checkout.new

    checkout.basket.should be {}
  end

  it "will ad item to basket when scanning" do
    checkout = Checkout.new

    checkout.scan 'GR1'
    checkout.basket.count.should eq 1
  end

  it "will display total price when prompted" do
    checkout = Checkout.new

    checkout.scan 'GR1'
    checkout.total.should eq '£3.11'
  end

  it "will apply green tea discount" do
    checkout = Checkout.new([Rule::GreenTea, Rule::Strawberries])
    
    checkout.scan 'GR1'
    checkout.total.should eq '£3.11'
    checkout.basket.count.should eq 1

    checkout.scan 'GR1'
    checkout.total.should eq '£3.11'
    checkout.basket.count.should eq 2

    checkout.scan 'GR1'
    checkout.total.should eq '£6.22'
    checkout.basket.count.should eq 3

    checkout.scan 'GR1'
    checkout.total.should eq '£6.22'
    checkout.basket.count.should eq 4

    checkout.scan 'GR1'
    checkout.total.should eq '£9.33'
    checkout.basket.count.should eq 5
  end

  it "will apply SR1 discount" do
    checkout = Checkout.new([Rule::GreenTea, Rule::Strawberries])
    
    checkout.scan 'SR1'
    checkout.total.should eq '£5.00'
    checkout.basket.count.should eq 1

    checkout.scan 'SR1'
    checkout.total.should eq '£10.00'
    checkout.basket.count.should eq 2

    checkout.scan 'SR1'
    checkout.total.should eq '£13.50'
    checkout.basket.count.should eq 3

    checkout.scan 'SR1'
    checkout.total.should eq '£18.00'
    checkout.basket.count.should eq 4
  end

  it "returns £22.45 for Basket: GR1,SR1,GR1,GR1,CF1" do
    checkout = Checkout.new([Rule::GreenTea, Rule::Strawberries])
    ['GR1','SR1','GR1','GR1','CF1'].each { |item| checkout.scan item }

    checkout.total.should eq '£22.45'
  end

  it "returns £3.11 for Basket: GR1,GR1" do
    checkout = Checkout.new([Rule::GreenTea, Rule::Strawberries])
    ['GR1','GR1'].each { |item| checkout.scan item }

    checkout.total.should eq '£3.11'
  end

  it "returns £16.61 for Basket: SR1,SR1,GR1,SR1" do
    checkout = Checkout.new([Rule::GreenTea, Rule::Strawberries])
    ['SR1','SR1','GR1','SR1'].each { |item| checkout.scan item }

    checkout.total.should eq '£16.61'
  end

end
