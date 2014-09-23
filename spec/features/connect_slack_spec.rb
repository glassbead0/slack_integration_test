require 'rails_helper'

feature 'user can connect slack' do
  scenario 'after loggin in' do
    user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_link 'Connect Slack'

  end
end
