include Warden::Test::Helpers
Warden.test_mode!

# Feature: User index page
#   As a user
#   I want to see a list of users
#   So I can see who has registered
feature 'User index page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User listed on index page
  #   Given I am signed in
  #   When I visit the user index page
  #   Then I see my own name and email address
  #   And I see other user's name and email address
  scenario 'user sees own email address' do
    user       = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
    visit users_path
    expect(page).to have_content user.name
    expect(page).to have_content user.email
    expect(page).to have_content other_user.name
    expect(page).to have_content other_user.email
  end

end
