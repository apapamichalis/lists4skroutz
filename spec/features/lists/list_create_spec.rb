require 'support/factory_girl'
require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!


feature "AddNewList", :type => :feature do

  it "should require the user log in before adding a list" do
    
    password = "password"
    u = create( :user, password: password, password_confirmation: password )

    visit new_user_list_path(u.id)

    # We should also test here for redirection to login page...

    within "#new_user" do
      fill_in "user_email",    with: u.email
      fill_in "user_password", with: password
    end

    click_button "Log in"

    within "#new_list" do
      fill_in "list_name", with: "Yet another list"
    end

    click_link_or_button "Create List"

    expect( List.count ).to eq(1)
    expect( List.first.name).to eq( "Yet another list")
  end

end