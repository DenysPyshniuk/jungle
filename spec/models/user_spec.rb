require 'rails_helper'

RSpec.describe User, type: :model do

describe 'Validations' do
  # CREATE NEW USER BEFORE EACH TEST
  before(:each) do
    @user = User.new
  end

  context "All fields are valid" do
    it "should create a user when all fields are filled in" do
      @user.first_name = "Denys"
      @user.last_name = "Pyshniuk"
      @user.email = "denys@test.com"
      @user.password = "qwerty"
      @user.password_confirmation = "qwerty"
      @user.save
    end
  end

  context "Passwords tests" do
    it "should not create a user when password field is blank" do
      @user.first_name = "Denys"
      @user.last_name = "Pyshniuk"
      @user.email = "denys@test.com"
      @user.password = nil
      @user.password_confirmation = "qwerty"
      @user.save
      # @user.errors.full_messages
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should not create a user when password less then 4 characters" do
      @user.first_name = "Denys"
      @user.last_name = "Pyshniuk"
      @user.email = "denys@test.com"
      @user.password = "123"
      @user.password_confirmation = "123"
      @user.save
      # @user.errors.full_messages
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end

    it "should not create a user when the password fields do not match" do
      @user.first_name = "Denys"
      @user.last_name = "Pyshniuk"
      @user.email = "denys@test.com"
      @user.password = "qwerty"
      @user.password_confirmation = "qwer"
      @user.save
      # @user.errors.full_messages
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  context "Same Email test" do
    it "should not create a user when the email is already registered" do
      @user1 = User.new
      @user1.first_name = "Denys"
      @user1.last_name = "Pyshniuk"
      @user1.email = "denys@test.com"
      @user1.password = "qwerty"
      @user1.password_confirmation = "qwerty"
      @user1.save

      @user.first_name = "Tester"
      @user.last_name = "Test"
      @user.email = "denys@test.com"
      @user.password = "qwerty"
      @user.password_confirmation = "qwerty"
      @user.save
      @user.errors.full_messages
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end
  end
end

  describe 'authenticate with credentials' do
    # CREATE NEW USER BEFORE EACH TEST
    before(:each) do
      @user = User.new
    end

    context "Corectness of the data" do
      it "should pass when data is correct" do
        @user.first_name = "Denys"
        @user.last_name = "Pyshniuk"
        @user.email = "denys@test.com"
        @user.password = "qwerty"
        @user.password_confirmation = "qwerty"
        @user.save!
        @user = User.authenticate_with_credentials("denys@test.com", "qwerty")
        expect(@user).not_to be(nil)
      end

      it "should not pass when data is not correct" do
        @user.first_name = "Denys"
        @user.last_name = "Pyshniuk"
        @user.email = "denys@test.com"
        @user.password = "qwerty"
        @user.password_confirmation = "qwerty"
        @user.save!
        @user = User.authenticate_with_credentials("test@test.com", "1234")
        expect(@user).to be(nil)
      end
    end

    context "Email tests" do
      it "should pass when email has extra spaces" do
        @user.first_name = "Denys"
        @user.last_name = "Pyshniuk"
        @user.email = "denys@test.com"
        @user.password = "qwerty"
        @user.password_confirmation = "qwerty"
        @user.save!
        @user = User.authenticate_with_credentials("  denys@test.com  ",   "qwerty")
        expect(@user).not_to be(nil)
      end

      it "should pass when email not casesensetive" do
        @user.first_name = "Denys"
        @user.last_name = "Pyshniuk"
        @user.email = "denys@test.com"
        @user.password = "qwerty"
        @user.password_confirmation = "qwerty"
        @user.save!
        @user = User.authenticate_with_credentials("DenyS@TesT.com", "qwerty")
        expect(@user).not_to be(nil)
      end
    end
  end
end