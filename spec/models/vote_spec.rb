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
end