require 'support/factory_girl'


describe List do

  # :user and :list declared in their respective factories
  before(:each) do
    @user1 = build(:user)
    @list = build(:list)
    @list.user = @user1
    @list.save
  end

  subject { @list }

  it { should respond_to(:name) }

  it "name returns a string" do
    expect(@list.name).to match 'First List'
  end

  it "user.name returns the name of the owner" do 
    expect(@list.user).to match @user1
  end

  it "can be updated" do 
    @list.name = 'Yolo'
    @list.save
    expect(@list.name).to match 'Yolo'
  end

  it "can have its active status changed" do 
    expect(@list.active).to match true
    @list.active = false
    @list.save
    expect(@list.active).to match false
  end

end
