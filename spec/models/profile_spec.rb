require 'rails_helper'

describe Profile do
  describe '#create' do
    before do
      @user = create(:user)
    end

    it "is valid with a family_name, first_name, family_name_kana, first_name_kana, birthday" do
      profile = build(:profile, user_id: @user.id)
      expect(profile).to be_valid
    end

    it "is invalid without family_name" do
      profile = build(:profile, family_name: nil, user_id: @user.id)
      profile.valid?
      expect(profile.errors[:family_name]).to include("を入力してください")
    end

    it "is invalid without first_name" do
      profile = build(:profile, first_name: nil, user_id: @user.id)
      profile.valid?
      expect(profile.errors[:first_name]).to include("を入力してください")
    end

    it "is invalid without family_name_kana" do
      profile = build(:profile, family_name_kana: nil, user_id: @user.id)
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("を入力してください")
    end

    it "is invalid without first_name_kana" do
      profile = build(:profile, first_name_kana: nil, user_id: @user.id)
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("を入力してください")
    end

    it "is invalid without birthday" do
      profile = build(:profile, birthday: nil, user_id: @user.id)
      profile.valid?
      expect(profile.errors[:birthday]).to include("を入力してください")
    end

    it "is invalid family_name include other than katakana, hiragana, kanji" do
      profile = build(:profile, family_name: "aaa", user_id: @user.id)
      profile.valid?
      expect(profile.errors[:family_name]).to include("ひらがな、カタカナ、漢字以外の文字が含まれています")
    end

    it "is invalid first_name include other than katakana, hiragana, kanji" do
      profile = build(:profile, first_name: "aaa", user_id: @user.id)
      profile.valid?
      expect(profile.errors[:first_name]).to include("ひらがな、カタカナ、漢字以外の文字が含まれています")
    end

    it "is invalid family_name_kana include other than katakana" do
      profile = build(:profile, family_name_kana: "あああ", user_id: @user.id)
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("カタカナで入力してください")
    end

    it "is invalid first_name_kana include other than katakana" do
      profile = build(:profile, first_name_kana: "あああ", user_id: @user.id)
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("カタカナで入力してください")
    end

    it "is valid with family_name include hiragana, katakana, kanji and '-'" do
      profile = build(:profile, family_name: "あ亜アー", user_id: @user.id)
      expect(profile).to be_valid
    end

    it "is valid with first_name include hiragana, katakana, kanji and '-'" do
      profile = build(:profile, first_name: "あ亜アー", user_id: @user.id)
      expect(profile).to be_valid
    end
  end
end
