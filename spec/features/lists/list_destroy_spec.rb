include Warden::Test::Helpers
Warden.test_mode!

# Feature: Registered deletes a list he owns
#   As a registered user
#   I want to destroy a list
feature "List destroy", :type => :feature do

  # Scenario: User deletes a list
  #   Given I am signed up
  #   When I visit the list page
  #   Then I click on the delete button
  #   And confirm my decision
  #   And the list gets deleted
  scenario "requires confirmation before deleting" do
    user = FactoryGirl.create(:user)
    list = FactoryGirl.create(:list, user: user)
    visit root_path
    click_link "Sign in"
    within "#new_user" do
      fill_in "user_email",    with: user.email
      fill_in "user_password", with: user.password
    end
    click_button "Sign in"
    click_link "My Lists"
    expect {
      click_link "Delete"
    }.to change(List, :count).by(-1)
    expect(page).to have_content 'List was successfully destroyed.', count: 1
  end
end
