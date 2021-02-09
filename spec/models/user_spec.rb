require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # CREATE NEW USER BEFORE EACH TEST
    before (:each) do
      @user = User.new(name:"Denys Pyshniuk", email: "denys@gmail.com", password: "password", password_confirmation: "password")
      @user.save!
    end

  end
end
