require 'rails_helper'

RSpec.describe Listproduct, type: :model do
  before(:each) do 
    @user = FactoryGirl.create(:user)
    @list = @user.lists.create(name: "Test List")
  end

  it "is valid with a list and an SKU" do 
    @lp = @list.listproducts.create(skuid: 404)
    expect(@lp).to be_valid
  end

  it "is invalid without an SKU" do 
    lp = @list.listproducts.build
    expect(lp).not_to be_valid
  end

  it "is invalid without a list" do
    lp = FactoryGirl.build(:listproduct, list: nil, skuid: 404)
    expect(lp).not_to be_valid
  end

  it "does not allow for duplicate sku per list" do
    lp  = FactoryGirl.create(:listproduct, list: @list, skuid: 404)
    lp2 = FactoryGirl.build(:listproduct, list: @list, skuid: 404)
    expect(lp).to be_valid
    expect(lp2).not_to be_valid
  end

  it "gets deleted along with its list" do 
    lp  = FactoryGirl.create(:listproduct, list: @list, skuid: 404)
    expect{
      @list.destroy
    }.to change(Listproduct, :count).by(-1)
  end
end