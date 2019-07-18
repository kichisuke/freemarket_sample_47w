require 'rails_helper'
describe Profile do
  describe '#create' do
    it "is valid with a family_name, first_name, family_name_kana, first_name_kana, birthday" do
      user = create(:user)
      profile = build(:profile, user_id: user.id)
      expect(profile).to be_valid
    end

    it "is invalid without family_name" do
      user = create(:user)
      profile = build(:profile, family_name: nil, user_id: user.id)
      profile.valid?
      expect(profile.errors[:family_name]).to include("を入力してください")
    end

    it "is invalid without first_name" do
      user = create(:user)
      profile = build(:profile, first_name: nil, user_id: user.id)
      profile.valid?
      expect(profile.errors[:first_name]).to include("を入力してください")
    end

    it "is invalid without family_name_kana" do
      user = create(:user)
      profile = build(:profile, family_name_kana: nil, user_id: user.id)
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("を入力してください")
    end

    it "is invalid without first_name_kana" do
      user = create(:user)
      profile = build(:profile, first_name_kana: nil, user_id: user.id)
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("を入力してください")
    end

    it "is invalid without birthday" do
      user = create(:user)
      profile = build(:profile, birthday: nil, user_id: user.id)
      profile.valid?
      expect(profile.errors[:birthday]).to include("を入力してください")
    end

    it "is invalid family_name include other than katakana, hiragana, kanji" do
      user = create(:user)
      profile = build(:profile,family_name: "aaa", user_id: user.id)
      profile.valid?
      expect(profile.errors[:family_name]).to include("は不正な値です")
    end

    it "is invalid first_name include other than katakana, hiragana, kanji" do
      user = create(:user)
      profile = build(:profile,first_name: "aaa", user_id: user.id)
      profile.valid?
      expect(profile.errors[:first_name]).to include("は不正な値です")
    end

    it "is invalid family_name_kana include other than katakana" do
      user = create(:user)
      profile = build(:profile,family_name_kana: "あああ", user_id: user.id)
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("は不正な値です")
    end

    it "is invalid first_name_kana include other than katakana" do
      user = create(:user)
      profile = build(:profile,first_name_kana: "あああ", user_id: user.id)
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("は不正な値です")
    end
  end
end
