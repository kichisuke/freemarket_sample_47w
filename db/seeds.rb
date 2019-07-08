require 'csv'

CSV.foreach('db/brands.csv', headers: true) do |row|
    brand = Brand.where(
      id: row[0],
      name: row[1],
      created_at: row[2],
      updated_at: row[3]).first_or_initialize
    brand.save!
end

# CSV.foreach('db/item_images.csv', headers: true) do |row|
#   Item_image.create(
#     url: row['url'],
#     item_id: row['item_id'],
#     created_at: row['created_at'],
#     updated_at: row['updated_at'])
# end

# CSV.foreach('db/items.csv', headers: true) do |row|
#   Item.create!(
#     name: row[1],
#     price: row[2],
#     text: row[3],
#     condition: row[4],
#     delivery_charge: row[5],
#     delivery_method: row[6],
#     prefecture_id: row[7],
#     estimated_shipping_date: row[8],
#     category_id: row[9],
#     brand_id: row[10],
#     size: row[11],
#     saler_id: row[12],
#     buyer_id: row[13],
#     sales_status: row[14],
#     created_at: row[15],
#     updated_at: row[16])
# end
