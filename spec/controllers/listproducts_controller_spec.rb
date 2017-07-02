require 'rails_helper'

RSpec.describe ListproductsController, type: :controller do
   before(:each) do
    @user       = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user, email: "otheruser@example.com")
    @list       = @user.lists.create(name: "A Test List")
    @lp         = @list.listproducts.create(skuid: 404)
  end

  describe "#create" do 
    context "as an authorized user" do 
      context "with valid attributes" do 
        it "adds a listproduct" do 
          sign_in @user
          expect {
            post :create, params: { search: 32222, user_id: @user.id, list_id: @list.id }
          }.to change(@list.listproducts, :count).by(1)
        end
      end
    end

    context "as an unauthorized user" do 
      it "does not add a listproduct" do
        sign_in @other_user
        expect {
          post :create, params: { search: 32222, user_id: @user.id, list_id: @list.id }
        }.to_not change(@user.lists, :count)
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

  describe "#destroy" do 
    context "as an authorized user" do 
      it "destroys the listproduct" do 
        sign_in @user
        expect {
          delete :destroy, params: { search: @lp.skuid, user_id: @user.id, list_id: @list.id }
        }.to change(@list.listproducts, :count).by(-1)
      end
    end

    context "as an unauthorized user" do 
      it "does not destroy the listproduct" do
        sign_in @other_user
        expect {
          delete :destroy, params: { search: @lp.skuid, user_id: @user.id, list_id: @list.id }
        }.not_to change(@user.lists, :count)
      end

      it "redirects to the dashboard" do
        sign_in @other_user
          delete :destroy, params: { search: @lp.skuid, user_id: @user.id, list_id: @list.id }
        expect(response).to redirect_to root_path
      end
    end

    context "as a guest" do 
      it "does not destroy the listproduct" do 
        expect {
          delete :destroy, params: { search: @lp.skuid, user_id: @user.id, list_id: @list.id }
        }.not_to change(@user.lists, :count)
      end

      it "redirects to sign in" do 
          delete :destroy, params: { search: @lp.skuid, user_id: @user.id, list_id: @list.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
