require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe "#index" do
    # 正常なレスポンスか？
    it "responds successfully" do
      get :index
      expect(response).to be_success
      end
    # 200レスポンスが返ってきているか？
    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end
end
