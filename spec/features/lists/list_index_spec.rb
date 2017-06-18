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

  pending "index requires user to be logged in first" do 
    raise
  end

  pending "pagination should show up to 10 lists" do 
    raise
  end

  pending "pagination should return next 10 lists when requested" do 
    raise
  end
end