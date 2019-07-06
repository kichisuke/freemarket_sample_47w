FactoryBot.define do
  factory :item do
    name                    {"Tシャツ"}
    price                   {"1000"}
    text                    {"白Tシャツ"}
    condition               {"brand_new"}
    delivery_charge         {"postage_included"}
    delivery_method         {"mercari"}
    prefecture_id           {"27"}
    estimated_shipping_date {"shipping1"}
    category_id             {"3"}
    brand_id                {"1"}
    size                    {"m"}
    saler_id                {"1"}
    buyer_id                {""}
    sales_status            {"exhibition"}
  end
end
