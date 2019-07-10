require 'csv'

CSV.foreach('db/users.csv', headers: true) do |row|
  user = User.new(
    id: row[0],
    nickname: row[1],
    email: row[2],
    password: row[3],
    avatar_image: row[4],
    reset_password_token: row[5],
    reset_password_sent_at: row[6],
    remember_created_at: row[7],
    created_at: row[8],
    updated_at: row[9])
  user.save!
end

CSV.foreach('db/brands.csv', headers: true) do |row|
    brand = Brand.where(
      id: row[0],
      name: row[1],
      created_at: row[2],
      updated_at: row[3]).first_or_initialize
    brand.save!
end

CSV.foreach('db/categories.csv', headers: true) do |row|
    category = Category.where(
      id: row[0],
      name: row[1],
      parent_id: row[2],
      created_at: row[3],
      updated_at: row[4]).first_or_initialize
    category.save!
end

CSV.foreach('db/items.csv', headers: true) do |row|
    item = Item.where(
      id: row[0],
      name: row[1],
      price: row[2],
      text: row[3],
      condition: row[4],
      delivery_charge: row[5],
      delivery_method: row[6],
      prefecture_id: row[7],
      estimated_shipping_date: row[8],
      category_id: row[9],
      brand_id: row[10],
      size: row[11],
      saler_id: row[12],
      buyer_id: row[13],
      sales_status: row[14],
      created_at: row[15],
      updated_at: row[16]).first_or_initialize
    item.save!
end

CSV.foreach('db/item_images.csv', headers: true) do |row|
  item_image = ItemImage.where(
    id: row[0],
    url: row[1],
    item_id: row[2],
    created_at: row[3],
    updated_at: row[4]).first_or_initialize
  item_image.save!
end
