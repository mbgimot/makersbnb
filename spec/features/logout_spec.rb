require 'spec_helper'
include SessionHelpers

feature 'User signs out' do

  before(:each) do
    User.create(name: 'name',
    email: 'test@test.com',
    password: 'password',
    password_conf: 'password')
  end

  scenario 'while being signed in' do
    sign_in('test@test.com', 'password')
    click_button 'Logout'
    expect(page).to have_content('Goodbye!')
    expect(page).not_to have_content('Welcome, name')
    expect(page).to have_current_path('/')
  end
end
