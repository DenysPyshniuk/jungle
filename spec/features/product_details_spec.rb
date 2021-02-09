require 'rails_helper'

  RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They could navigate from home page to the product" do
    # ACT
    visit root_path

    # VERIFY
    first('article.product').find_link('Details').click
    expect(page).to have_css '.dl-horizontal'

    # DEBUG
    save_screenshot

  end

end
