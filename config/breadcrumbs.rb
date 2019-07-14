crumb :root do
  link "メルカリ", root_path
end

crumb :profile do
  link "プロフィール", mypage_profile_path
  parent :root
end
