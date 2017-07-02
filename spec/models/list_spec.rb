require 'rails_helper'

RSpec.describe List, type: :model do
  before(:each) do 
    @user = FactoryGirl.create(:user)
    @list = @user.lists.create(name: "Test List")
  end

  it "is valid with a user and a name" do 
    expect(FactoryGirl.create(:list, name: 'Yet another list', user: @user)).to be_valid
  end

  it "is invalid without a user" do 
    list = FactoryGirl.build(:list, name: 'Yet another list', user: nil)
    list.valid?
    expect(list).not_to be_valid
  end

  it "is invalid without a name" do 
    list = FactoryGirl.build(:list, name: nil, user: @user)
    list.valid?
    expect(list).not_to be_valid
  end

  it "does not allow duplicate list names per user" do 
    other_list = @user.lists.build(name: "Test List")
    other_list.valid?
    expect(other_list.errors[:name]).to include("has already been taken")
  end

  it "allows duplicate list names for different users" do 
    other_user = FactoryGirl.build(:user, email: "anothermail@example.com")
    other_list = other_user.lists.build(name: @list.name)
    other_list.valid?
    expect(other_list).to be_valid
  end

  it "returns its name as a string" do 
    expect(@list.name).to match "Test List"
  end

  it "returns the name of its creator with user.name" do 
    expect(@list.user.name).to match @user.name
  end

  it "can have its name updated" do 
    @list.name = 'Yolo'
    @list.save
    expect(@list.name).to match 'Yolo'
  end

  it "can have its active status changed" do 
    expect(@list.active).to match true
    @list.active = false
    @list.save
    @list.reload
    expect(@list.active).to match false
  end

  it "gets deleted along with its owner" do 
    expect{
      @user.destroy
    }.to change(List.all, :count).by(-1)
  end

end
