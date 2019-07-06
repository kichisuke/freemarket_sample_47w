require 'rails_helper'
describe ItemsController, type: :controller do

  describe 'GET #purchase' do
    it "assigns the requested item to @item" do
      item = create(:item)
      get :purchase, params: {id: item}
      expect(assigns(:item)).to eq item
    end
    it "renders the :purchase template" do
      get :purchase
      expect(response).to render_template :purchase
    end
  end
end
