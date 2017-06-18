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

  pending "can be edited by its owner" do 
    raise
  end

  pending "cannot be edited by other user (not its owner)" do 
    raise
  end

end