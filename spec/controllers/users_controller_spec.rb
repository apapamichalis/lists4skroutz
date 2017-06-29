require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @user       = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user, email: "otheruser@example.com")
  end

  describe "#index" do 
    context "as an authenticated user" do 
      
      it "responds successfully" do 
        sign_in @user
        get :index
        expect(response).to be_success
      end

      it "returns a 200 response" do 
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "as a unauthenticated (guest) user" do 
      it "returns a 302 response" do 
        get :index
        expect(response).to have_http_status "302"
      end

      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do
    context "as an authorized user" do
      it "responds successfully" do 
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to be_success
      end

      it "returns a 302 response when requesting to #show another user" do
        sign_in @user
        get :show, params: { id: @other_user.id }
        expect(response).to have_http_status "302"
      end

      it "redirects when requesting to #show another user" do
        sign_in @user
        get :show, params: { id: @other_user.id }
        expect(response).to redirect_to user_lists_path(@other_user)
      end
    end

    context "as a guest" do
      it "returns a 302" do
        get :show, params: { id: @other_user.id }
        expect(response).to have_http_status "302"
      end

      it "redirects to sign in" do
        get :show, params: { id: @other_user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
