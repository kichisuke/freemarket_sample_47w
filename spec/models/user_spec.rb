require 'rails_helper'
describe User do
  describe '#create' do
    it "is valid with a nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "is invalid without email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "is invalid without password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "is invalid without password_confirmation" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
      end

    it "id invalid with a password that has more less than 5" do
      user = build(:user, password: "12345", password_confirmation: "12345")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "is valid with a password length more than 6" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with a duplicate email address" do
      user = create(:user, email: "user@gmail.com")
      another_user = build(:user, email: "user@gmail.com")
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
  end
end
