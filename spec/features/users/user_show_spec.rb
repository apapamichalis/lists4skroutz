include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit user_path(user)
    expect(page).to have_content 'User'
    expect(page).to have_content user.email
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I am redirected to the other user's lists index
  #   And I don't see the other user's profile
  scenario "user cannot see another user's profile" do
    user       = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user, email: 'other@example.com')
    list       = FactoryGirl.create(:list, user: other_user)
    login_as(user, :scope => :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit user_path(other_user)
    expect(page).to have_content list.name
    expect(page).not_to have_content user.name
    expect(page).not_to have_content user.email
  end
end
