require 'spec_helper'

feature 'viewing submitted and recieved requests' do

  before(:each) do
    owner = User.create(name: 'name',
      email: 'test@test.com',
      password: 'password',
      password_conf: 'password'
    )
    rentee = User.create(name: 'person',
      email: 'person@test.com',
      password: 'password',
      password_conf: 'password'
    )
    space = owner.spaces.create(name: 'name',
      description: 'description',
      price: 90.00,
      date_available: '2017-02-10 00:00:00'
    )
    request = space.requests.create(date_requested: '2017-02-10 00:00:00', user: rentee)
  end

  scenario 'requests page has correct details' do
    sign_in('person@test.com', 'password')

    visit '/requests/view'

    expect(page).to have_content('Requests made')
    expect(page).to have_content('Owner: name')
    expect(page).to have_content('Rentee: person')
  end

end
