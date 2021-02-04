class Admin::DashboardController < ApplicationController
  def show
    @products_amount = Product.count
    @categories_amount = Category.count
  end
end
