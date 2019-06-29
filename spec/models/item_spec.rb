require 'rails_helper'
describe Item do
  describe '#index' do
    it "gets 4 latest dates for specified category" do
      item = Item.where("category_id = '1'").order('created_at DESC').limit(4)
      expect(item).to be_truthy
    end
    it "gets 4 latest dates for specified category" do
      item = Item.where("category_id = '2'").order('created_at DESC').limit(4)
      expect(item).to be_truthy
    end
  end
end
