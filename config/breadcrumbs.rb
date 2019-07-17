crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", mypage_path
  parent :root
end

crumb :profile do
  link "プロフィール", mypage_profile_path
  parent :mypage
end

crumb :card do
  link "支払い方法", mypage_card_path
  parent :mypage
end

crumb :identification do
  link "支払い方法", mypage_identification_path
  parent :mypage
end

