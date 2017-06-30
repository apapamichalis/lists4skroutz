include Warden::Test::Helpers
Warden.test_mode!

# Feature: Registered user has his lists sorted by date
#   As a registered user
#   I want my lists sorted by date by default
#   So I can see the last created first
feature 'Lists sort by date', :type => :feature do

  # Scenario: User visits lists index
  #   Given I am signed in
  #   When I visit my lists index page
  #   Then I see my lists sorted by date (newest first)
  scenario 'visits index page' do
    user =  FactoryGirl.create(:user)
    list1 = FactoryGirl.create(:list, user: user, created_at: 1.day.ago)
    list2 = FactoryGirl.create(:list, user: user, created_at: 2.days.ago)
    list3 = FactoryGirl.create(:list, user: user, created_at: 2.minutes.ago)
    visit root_path
    click_link 'Sign in'
    within '#new_user' do
      fill_in 'user_email',    with: user.email
      fill_in 'user_password', with: user.password
    end
    click_button 'Sign in'
    click_link 'My Lists'
    expect(page).to have_content('My Lists'), count:2
    expect(page).to have_content(list1.name)
    expect(page.body.index(list1.name)).to be < page.body.index(list2.name)
    expect(page.body.index(list3.name)).to be < page.body.index(list2.name)
  end
end