require 'rails_helper'

RSpec.describe Lists::VotesController, type: :controller do
  before(:each) do
    @user       = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user, email: "otheruser@example.com")
    @list       = @user.lists.create(name: "A Test List")
    
  end

  describe "#create" do 
    context "as an authenticated user" do 
      it "adds a vote" do 
          sign_in @user
          expect {
            post :create, params: { list_id: @list.id, user_id: @user.id }
          }.to change(@list.votes, :count).by(1)
      end
    end

    context "as unauthorized user" do 
      it "it adds a vote" do
          sign_in @other_user
          expect {
            post :create, params: { list_id: @list.id, user_id: @other_user.id  }
          }.to change(@list.votes, :count).by(1)
      end
    end

    context "as a guest" do 
      it "it does not add vote" do
        expect {
            post :create, params: { list_id: @list.id, user_id: @user.id  }
          }.not_to change(@list.votes, :count)
      end

      it "redirects to sign in" do 
        post :create, params: { list_id: @list.id, user_id: @user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy" do 
    before(:each) do 
      @vote = Vote.create(user: @user, list: @list)
    end
    context "as an authenticated user" do 
      it "deletes a vote" do 
          sign_in @user
          expect {
            post :destroy, params: { list_id: @list.id, user_id: @user.id }
          }.to change(@list.votes, :count).by(-1)
      end
    end

    context "as unauthorized user" do 
      it "it deletes a vote" do
          sign_in @other_user
          expect {
            post :destroy, params: { list_id: @list.id, user_id: @user.id  }
          }.not_to change(@list.votes, :count)
      end
    end

    context "as a guest" do 
      it "it does not add vote" do
        expect {
            post :destroy, params: { list_id: @list.id, user_id: @user.id  }
          }.not_to change(@list.votes, :count)
      end

      it "redirects to sign in" do 
        post :destroy, params: { list_id: @list.id, user_id: @user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


end
