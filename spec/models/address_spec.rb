require 'rails_helper'

describe Address do
  describe '#signup_create' do
    before do
      @user = create(:user)
    end

    it "is valid with postal_code, prefecture_id, city, street_address, building, phone_number" do
      address = build(:address, user_id: @user.id)
      expect(address).to be_valid
    end

    it "is valid without building, phone_number" do
      address = build(:address, building: nil, phone_number: nil, user_id: @user.id)
      expect(address).to be_valid
    end

    it "is invalid without postal_code" do
      address = build(:address, postal_code: nil, user_id: @user.id)
      address.valid?
      expect(address.errors[:postal_code]).to include("を入力してください")
    end

    it "is invalid without prefecture_id" do
      address = build(:address, prefecture_id: nil, user_id: @user.id)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end

    it "is invalid without city" do
      address = build(:address, city: nil, user_id: @user.id)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it "is invalid without street_address" do
      address = build(:address, street_address: nil, user_id: @user.id)
      address.valid?
      expect(address.errors[:street_address]).to include("を入力してください")
    end

    it "is invalid postal_code more than 7 characters" do
      address = build(:address, postal_code: "123-45678", user_id: @user.id)
      address.valid?
      expect(address.errors[:postal_code]).to include("指定した形式でご入力ください")
    end

    it "is invalid postal_code without '-'" do
      address = build(:address, postal_code: "1234567", user_id: @user.id)
      address.valid?
      expect(address.errors[:postal_code]).to include("指定した形式でご入力ください")
    end

    it "is invalid phone_number less than 9 characters" do
      address = build(:address, phone_number: "090123456", user_id: @user.id)
      address.valid?
      expect(address.errors[:phone_number]).to include("10桁または11桁の数字のみでご入力ください")
    end

    it "is invalid phone_number more than 12 characters" do
      address = build(:address, phone_number: "090123456789", user_id: @user.id)
      address.valid?
      expect(address.errors[:phone_number]).to include("10桁または11桁の数字のみでご入力ください")
    end

    it "is invalid phone_number include except number" do
      address = build(:address, phone_number: "a9012345678", user_id: @user.id)
      address.valid?
      expect(address.errors[:phone_number]).to include("10桁または11桁の数字のみでご入力ください")
    end

    it "is valid phone_number 10 characters" do
      address = build(:address, phone_number: "0901234567", user_id: @user.id)
      expect(address).to be_valid
    end
  end
end
