require 'rails_helper'

RSpec.describe ListproductsController, type: :controller do
   before(:each) do
    @user       = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user, email: "otheruser@example.com")
    @list       = @user.lists.create(name: "A Test List")
    @other_list = @other_user.lists.create(name: "Other Test List")
    @lp         = @list.listproducts.create(skuid: 404)
  end


  describe "#create" do 
    context "as an authenticated user" do 
      context "with valid attributes" do 
        it "adds a listproduct" do 
          sign_in @user
          expect {
            post :create, params: { search: 32222, user_id: @user.id, list_id: @list.id }
          }.to change(@list.listproducts, :count).by(1)
        end
      end

      context "with invalid attrbutes" do 
        it "does not add a listproduct to another user's list" do
          sign_in @other_user
          expect {
            post :create, params: { search: 32222, user_id: @user.id, list_id: @list.id }
          }.to_not change(@user.lists, :count)
        end

        pending "does not add a listproduct without an sku" do 
          sign_in @user
          expect {
            post :create, params: { search: nil, user_id: @user.id, list_id: @list.id }
          }.to_not change(@user.lists, :count)
        end
      end
    end

    context "as a guest" do 
      it "returns a 302 response" do
        post :create, params: { search: 32222, user_id: @user.id, list_id: @list.id }
        expect(response).to have_http_status "302"
      end

      it "redirects to sign in" do 
        post :create, params: { search: 32222, user_id: @user.id, list_id: @list.id }
        expect(response).to redirect_to new_user_session_path
      end

      it "does not add a listproduct" do 
        expect {
          post :create, params: { search: 32222, user_id: @user.id, list_id: @list.id }
        }.to_not change(@user.lists, :count)
      end
    end
  end

end
