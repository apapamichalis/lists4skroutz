# Needs feature specifications

require 'support/factory_girl'
include Warden::Test::Helpers
Warden.test_mode!

describe List do

  # :user and :list declared in their respective factories
  before(:each) do
    @user1 = build(:user)
    @user2 = build(:user, email:'another@email.com') 
    @list = build(:list)
    @list.user = @user1
    @list.save
  end

  subject { @list }

  pending "can be updated by its owner" do 
    raise
  end

  pending "can have its active status changed by its owner" do 
    raise
  end


  pending "cannot be updated by other user" do 
    raise
  end


end