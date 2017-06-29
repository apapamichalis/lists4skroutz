require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  before(:each) do
    @user       = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user, email: "otheruser@example.com")
    @list       = @user.lists.create(name: "A Test List")
  end

  describe "#index" do 
    context "as an authenticated user" do 
      
      it "responds successfully" do 
        sign_in @user
        get :index, params: { user_id: @user.id }
        expect(response).to be_success
      end

      it "returns a 200 response" do 
        sign_in @user
        get :index, params: { user_id: @user.id }
        expect(response).to have_http_status "200"
      end
    end

    context "as a unauthenticated (guest) user" do 
      it "returns a 302 response" do 
        get :index, { user_id: @user.id }
        expect(response).to have_http_status "302"
      end

      it "redirects to sign in page" do
        get :index, { user_id: @user.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do
    context "as an authorized user" do
      context "when requesting a list that belongs to me" do 
        it "responds successfully" do 
          sign_in @user
          get :show, params: { id: @list.id, user_id: @user.id }
          expect(response).to be_success
          expect(response).to have_http_status "200"
        end
      end

      context "when requesting a list that belongs to someone else" do 
        it "responds successfully" do
          sign_in @other_user
          get :show, params: { id: @list.id, user_id: @user.id }
          expect(response).to be_success
          expect(response).to have_http_status "200"
        end
      end
    end

    context "as a guest" do
      it "returns a 302 response" do
        get :show, params: { id: @list.id, user_id: @user.id }
        expect(response).to have_http_status "302"
      end

      it "redirects to sign in" do
        get :show, params: { id: @list.id, user_id: @user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#create" do 
    context "as an authenticated user" do 
      context "with valid attributes" do 
        it "adds a list" do 
          list_params = FactoryGirl.attributes_for(:list, name: "A title")
          sign_in @user
          expect {
            post :create, params: { list: list_params, user_id: @user.id }
          }.to change(@user.lists, :count).by(1)
        end
      end

      context "with invalid attrbutes" do 
        it "does not add a list to another user" do
          list_params = FactoryGirl.attributes_for(:list, name: "A title")
          sign_in @other_user
          expect {
            post :create, params: { list: list_params, user_id: @user.id }
          }.to_not change(@user.lists, :count)
        end

        it "does not add a list without a name" do 
          list_params = FactoryGirl.attributes_for(:list, name: nil)
          sign_in @user
          expect {
            post :create, params: { list: list_params, user_id: @user.id }
          }.to_not change(@user.lists, :count)
        end
      end
    end

    context "as a guest" do 
      it "returns a 302 response" do
        list_params = FactoryGirl.attributes_for(:list, name: "A title")
        post :create, params: { list: list_params, user_id: @user.id }
        expect(response).to have_http_status "302"
      end

      it "redirects to sign in" do 
        list_params = FactoryGirl.attributes_for(:list, name: nil)
        post :create, params: { list: list_params, user_id: @user.id }
        expect(response).to redirect_to new_user_session_path
      end

      it "does not add a list" do 
        list_params = FactoryGirl.attributes_for(:list, name: "A title")
        expect {
          post :create, params: { list: list_params, user_id: @user.id }
        }.to_not change(@user.lists, :count)
      end
    end
  end
end
