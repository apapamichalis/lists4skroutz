include Warden::Test::Helpers
Warden.test_mode!

# Feature: Registered user can search the lists of a user
#   As a registered user
#   I want to search other's and my lists 
#   So I can find them fater
feature 'Lists search', :type => :feature do
  before(:each) do 
    @user       =  FactoryGirl.create(:user)
    @other_user =  FactoryGirl.create(:user)
    @list1      =  FactoryGirl.create(:list, user: @user)
    @list2      =  FactoryGirl.create(:list, user: @user)
    @list3      =  FactoryGirl.create(:list, user: @other_user)
    @list4      =  FactoryGirl.create(:list, user: @other_user)
  end
  # Scenario: User searches for lists
  #   Given I am signed in
  #   When I visit my lists index page
  #   And I search by list name
  #   Then I find the lists I am looking for
  #   And I visit an other user's lists page
  #   And I search by list name
  #   And I find the lists I am looking for
  scenario 'in my lists index page' do
    visit root_path
    click_link 'Sign in'
    within '#new_user' do
      fill_in 'user_email',    with: @user.email
      fill_in 'user_password', with: @user.password
    end
    click_button 'Sign in'
    
    click_link 'My Lists'
    expect(page).to have_content('My Lists'), count:2
    expect(page).to have_content(@list1.name)
    expect(page).to have_content(@list2.name)
    expect(page).not_to have_content(@list3.name)
    expect(page).not_to have_content(@list4.name)

    fill_in 'search', with: @list1.name
    
    click_button 'Search'
    expect(page).to have_content(@list1.name)
    expect(page).not_to have_content(@list2.name)
  end

  # Scenario: User searches for lists
  #   Given I am signed in
  #   When I visit my lists index page
  #   And I search by list name
  #   Then I find the lists I am looking for
  #   And I visit an other user's lists page
  #   And I search by list name
  #   And I find the lists I am looking for
  #   And I search without search term
  #   And I have all of the user's lists returned
  scenario "in other user's lists index page" do
    visit root_path
    click_link 'Sign in'
    within '#new_user' do
      fill_in 'user_email',    with: @user.email
      fill_in 'user_password', with: @user.password
    end
    click_button 'Sign in'
    
    click_link 'My Lists'
    expect(page).to have_content(@list1.name)
    expect(page).to have_content(@list2.name)

    click_link 'Users'
    click_link @other_user.email
    expect(page).to have_content('My Lists'), count:2
    expect(page).not_to have_content(@list1.name)
    expect(page).not_to have_content(@list2.name)
    expect(page).to have_content(@list3.name)
    expect(page).to have_content(@list4.name)

    fill_in 'search', with: @list3.name
    click_button 'Search'
    expect(page).to have_content(@list3.name)
    expect(page).not_to have_content(@list4.name)

    fill_in 'search', with: ''
    click_button 'Search'
    expect(page).to have_content(@list3.name)
    expect(page).to have_content(@list4.name)
  end

end