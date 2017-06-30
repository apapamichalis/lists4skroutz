include Warden::Test::Helpers
Warden.test_mode!

# Feature: Registered user creates a list
#   As a registered user
#   I want to create a new list
#   So I can do something useful with the app
feature "List create", :type => :feature do

  # Scenario: User creates a list
  #   Given I am signed up
  #   And I am not signed in
  #   When I visit the new list page
  #   Then I get redirected to sign in page
  #   And I can sign in
  #   And I am redirected to the new list page
  #   And I create my new list
  scenario "requires the user to log in before adding a list" do
    user = FactoryGirl.create(:user)
    visit new_user_list_path(user)
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    within "#new_user" do
      fill_in "user_email",    with: user.email
      fill_in "user_password", with: user.password
    end
    click_button "Sign in"
    expect(page).to have_button 'Create List' 
    within "#new_list" do
      fill_in "list_name", with: 'Yet another list'
    end
    click_link_or_button 'Create List'
    expect(page).to have_content 'List was successfully created.', count: 1
    expect(List.count).to eq(1)
    expect(List.first.name).to eq 'Yet another list'
  end
end