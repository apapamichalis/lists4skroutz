require 'rails_helper'

RSpec.describe Vote, type: :model do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @list = @user.lists.create(name: "My Awesome List")
  end

  it "is valid with a user and a list" do 
    vote = Vote.new(
      user: @user,
      list: @list
    )
    expect(vote).to be_valid
  end

  it "is invalid without a list" do 
    vote = Vote.new(
      user: @user,
      list: nil
    )
    expect(vote).not_to be_valid
  end

  it "is invalid without a user" do 
    vote = Vote.new(
      user: nil,
      list: @list
    )
    expect(vote).not_to be_valid
  end

  it "gets destroyed with list" do 
    vote = Vote.create(
      user: @user,
      list: @list
    )
    expect{@list.destroy}.to change(Vote.all, :count).by(-1)
  end

  it "gets destroyed with user" do 
    vote = Vote.create(
      user: @user,
      list: @list
    )
    expect{@user.destroy}.to change(Vote.all, :count).by(-1)
  end
end