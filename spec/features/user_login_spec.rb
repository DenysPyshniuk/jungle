require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  #SETUP
  before :each do
    @user = User.create!(
      first_name: 'First',
      last_name: 'One',
      email: 'first@gmail.com',
      password: '123456',
      password_confirmation: '123456'
    )
    @category = Category.create! name: 'Apparel'
    @category.products.create!(
      name: 'Cool Shirt',
      description: 'A really cool shirt.',
      image: 'test.jpg',
      quantity: 3,
      price: 12.99
    )
  end

scenario "They could login" do
    # ACT
    visit root_path
    click_on('Login')

    fill_in 'email', with: 'first@gmail.com'
    fill_in 'password', with: '123456'
    save_screenshot
    find('input[name="commit"]').click

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content 'Signed in as First'

  end
end
