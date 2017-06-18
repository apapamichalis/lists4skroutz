describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it "can be destroyed" do 
    expect{@list.destroy}.to change {List.count}.by(-1)
  end


  it "should be destroyed when its creator's account is destroyed" do 
    expect{@user.destroy}.to change {List.count}.by(-1)
  end

  
end
