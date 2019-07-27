FactoryBot.define do
  factory :address do
    postal_code         {"123-4567"}
    prefecture_id       {"14"}
    city                {"横浜市緑区"}
    street_address      {"青山1-1-1"}
    building            {"柳ビル103"}
    phone_number        {"09012345678"}
  end
end
