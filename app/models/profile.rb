class Profile < ApplicationRecord
  belongs_to :user

  validates :family_name, presence: true, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: "ひらがな、カタカナ、漢字以外の文字が含まれています" }
  validates :first_name, presence: true, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: "ひらがな、カタカナ、漢字以外の文字が含まれています" }
  validates :family_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "カタカナで入力してください" }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "カタカナで入力してください" }
  validates :birthday, presence: true
end
