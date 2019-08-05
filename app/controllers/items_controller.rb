class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy, :edit, :update, :purchase, :pay, :done, :access_denied]
  before_action :move_to_login, only: [:new, :purchase, :edit, :update, :destroy, :pay, :done]
  before_action :access_denied, only: [:edit, :update, :destroy]

  require "payjp"

  def index
    #レディースカテゴリーの4アイテムを最新の上から4つ抽出
    @radiesItem = pickup_category_items(1)
    #メンズカテゴリーの4アイテムを最新の上から4つ抽出
    @mensItem = pickup_category_items(2)
  end

  def pickup_category_items(id)
    # 引数で渡されたidの子カテゴリのidの配列を生成
    child_category_ids = Category.find(id).children.ids
    # 子カテゴリのidと合致する孫カテゴリのidの配列を生成
    grand_child_category_ids = Category.where("parent_id IN (?)", child_category_ids).ids
    # 孫カテゴリのidと合致するitemsの配列を生成
    items = Item.where("category_id IN (?)", grand_child_category_ids)
    # 最新の４件を取得
    items.order("created_at DESC").limit(4)
  end

  def show
    @otherItems = Item.where(saler_id: @item.saler_id).where.not(id: params[:id]).limit(3)
    @sameCategories = Item.where(category_id: @item.category_id).where.not(id: params[:id]).limit(3)
    @previousItem = Item.where('id < ?', params[:id]).order('id DESC').first
    @nextItem = Item.where('id > ?', params[:id]).order('id ASC').first
  end

  def new
    @categories = Category.eager_load(children: :children).where(parent_id: nil)
    @item = Item.new
    @item.item_images.build
  end

  def create
    @item = Item.new(item_params)
    if new_image_params[:images][0].present? && @item.save
      new_image_params[:images].each do |url|
        @item.item_images.create(url: url, item_id: @item.id)
      end
      redirect_to root_path, notice: '出品しました。'
    else
      render :new, alert: '出品出来ませんでした。'
    end
  end

  def category_search
    respond_to do |format|
      format.html
      format.json do
        @parent_category = Category.find(params[:parent_id])
        @child_categories = @parent_category.children
      end
    end
  end

  def brand_search
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%").limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def search
    @items = Item.where('name LIKE(?)', "%#{params[:keyword]}%")
  end

  def destroy
    if @item.saler_id == current_user.id
      @item.destroy
      @item.item_images.destroy
      redirect_to root_path, notice: "削除しました"
    else
      redirect_to root_path, notice: "削除できません"
    end
  end

  def edit
    @categories = Category.eager_load(children: :children).where(parent_id: nil)
    gon.item = @item
    gon.item_images = @item.item_images
    @registered_category = @item.category.parent.parent.id
    @registered_child_category = @item.category.parent.id
    @child_category_brother = child_category_brother_search(@item.category_id)
    @grand_child_category_brother = grand_child_category_brother_search(@item.category_id)
    if @item.brand.present?
      @registered_brand = @item.brand.name
    else
      @registered_brand = ""
    end

    require 'aws-sdk'
    gon.item_images_binary_datas = []

    if Rails.env.production?
      client = Aws::S3::Client.new(
                             region: 'ap-northeast-1',
                             access_key_id: Rails.application.secrets.aws_access_key_id,
                             secret_access_key: Rails.application.secrets.aws_secret_access_key,
                             )
      @item.item_images.each do |image|
        binary_data = client.get_object(bucket: 'mercari47w', key: image.url.file.path).body.read
        gon.item_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    else
      @item.item_images.each do |image|
        binary_data = File.read(image.url.file.file)
        gon.item_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    end
  end

  def update
    ids = @item.item_images.map{|image| image.id }
    exist_ids = registered_image_params[:ids].map(&:to_i)
    exist_ids.clear if exist_ids[0] == 0
    if (exist_ids.length != 0 || new_image_params[:images][0] != " ") && @item.update(item_params)
      unless ids.length == exist_ids.length
        delete_ids = ids - exist_ids
        delete_ids.each do |id|
          @item.item_images.find(id).destroy
        end
      end

      unless new_image_params[:images][0] == " "
        new_image_params[:images].each do |image|
          @item.item_images.create(url: image, item_id: @item.id)
        end
      end

      flash[:notice] = '編集が完了しました'
      redirect_to item_path(@item), data: {turbolinks: false}

    else
      flash[:alert] = '未入力項目があります'
      redirect_back(fallback_location: root_path)
    end
  end

  # 孫カテゴリーの兄弟要素を取得
  def grand_child_category_brother_search(id)
    # @itemのcategory_id（孫）から見たparent_id（子id）を取得
    grand_child_category_parent_id = Category.find(id).parent_id
    # @itemのcategory_id（孫）から見たparent_id（子id）と同じparent_id（子id）をもつレコードを取得
    grand_child_category_brother_ids = Category.where(parent_id: grand_child_category_parent_id)
    return grand_child_category_brother_ids
  end

  # 子カテゴリーの兄弟要素を取得
  def child_category_brother_search(id)
    # @itemのcategory_id（孫）から見たparent（子id）のもつparent_id（親）を取得
    child_category_parent_id = Category.find(id).parent.parent_id
    # @itemのcategory_id（孫）から見たparent（子）のもつparent_id（親）と同じparent_id（親）をもつレコードを取得
    child_category_brother_ids = Category.where(parent_id: child_category_parent_id)
  end

  def purchase
    if @item.saler_id == current_user.id || @item.sales_status != "exhibition"
      redirect_to action: 'show'
    else
      @card = Creditcard.where(user_id: current_user.id).first
      if @card.present?
        Payjp.api_key = "sk_test_5807e2b2840ba0fcf414ec61"
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @card_information = customer.cards.retrieve(@card.card_id)
        @card_brand = @card_information.brand
      end
    end
  end

  def pay
    if @item.saler_id == current_user.id || @item.sales_status != "exhibition"
      redirect_to action: 'show'
    else
      card = Creditcard.where(user_id: current_user.id).first
      Payjp.api_key = "sk_test_5807e2b2840ba0fcf414ec61"
      Payjp::Charge.create(customer: card.customer_id, amount: @item.price, currency: 'jpy')
      @item.buyer_id = current_user.id
      @item.sales_status = 2
      @item.save
      redirect_to action: 'done'
    end
  end

  def done
    unless @item.buyer_id == current_user.id || @item.sales_status == 2
      redirect_to action: 'show'
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :text, :category_id, :brand_id, :size, :condition, :delivery_charge, :delivery_method, :prefecture_id, :estimated_shipping_date, :sales_status).merge(saler_id: current_user.id)
  end

  def new_image_params
    params.require(:new_images).permit({images: []})
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_login
    redirect_to controller: 'users/sessions', action: 'new' unless user_signed_in?
  end

  def access_denied
    redirect_to root_path if @item.saler_id != current_user.id
  end

end
