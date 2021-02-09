require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
  # CREATE NEW CATEGORY AND PRODUCT BEFORE EACH TEST
    before (:each) do
      @category = Category.new(:name => "Games")
      @category.save!
      @product = Product.new(:name => "Willainous", :price => 54, :quantity => 5, :category => @category )
      @product.save
    end

    it "ensures that product with all fields will save successfully" do
        expect(@product).to be_valid
    end

    it "fails when name is not presented" do
      @product.name = nil
      @product.valid?
      puts @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product).to_not be_valid
      puts @product.errors.full_messages
    end

    it "fails when price is not presented" do
      @product.price_cents = nil
      @product.valid?
      puts @product.errors.full_messages
      expect(@product.errors.full_messages.to_sentence).to include("Price is not a number")
      expect(@product).to_not be_valid
    end

    it "fails when quantity is not presented" do
      @product.quantity = nil
      @product.valid?
      puts @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
      expect(@product).to_not be_valid
    end

    it "fails when category is not presented" do
      @product.category = nil
      @product.valid?
      puts @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Category can't be blank")
      expect(@product).to_not be_valid
    end

  end
end
