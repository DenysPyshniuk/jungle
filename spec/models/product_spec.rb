require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
  # CREATE NEW CATEGORY AND PRODUCT BEFORE EACH TEST
    before do
      @category = Category.new(name: "Games")
      @category.save
      @product = Product.new(:name => "Willainous", :price => 54, :quantity => 5, :category => @category )
      @product.save
    end

    it "ensures that product with all fields will save successfully" do
        expect(@product).to be_valid
    end






  end
end
