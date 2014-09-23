require 'rails_helper'

feature 'User authentication' do
  scenario 'new user signs up' do
    email = Faker::Internet.email
    visit '/'

    click_link 'Sign up'
    fill_in 'Email', with: email
    fill_in 'Password', with: 'somePassword'
    fill_in 'Password confirmation', with: 'somePassword'
    click_button 'Sign up'

    expect(page).to have_text "Signed in as #{email}"
  end

  scenario 'existing user logs in' do
    user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(page).to have_text "Signed in as #{user.email}"
  end
end
