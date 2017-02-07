module SessionHelpers
  def sign_up(name, email, password, password_conf)
    visit ('/users/new')
    fill_in 'name', with: name
    fill_in 'email', with: email
    fill_in 'password', with: password
    fill_in 'password_conf', with: password_conf
    click_button 'Sign Up'
  end


  def sign_in(email, password)
    visit ('/')
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Login'
  end
end


def sign_up_true
  visit ('/users/new')
  fill_in 'name', with: 'Betty'
  fill_in 'email', with: 'betty@bettymail.com'
  fill_in 'password', with: 'password'
  fill_in 'password_conf', with: 'password'
  click_button 'Sign Up'
end

def list_space
  click_link('List a space')
  fill_in(:name, with: 'House by the sea')
  fill_in(:description, with: 'Lovely two-bed apartment overlooking the sea.')
  fill_in(:price, with: '35.00')
  fill_in(:date_available, with:'2017-02-24')
  click_button('List space')
end

def list_another_space
  click_link('List a space')
  fill_in(:name, with: 'Penthouse apartment')
  fill_in(:description, with: 'Incredible views from this top storey apartment in London')
  fill_in(:price, with: '100.00')
  fill_in(:date_available, with:'2017-02-24')
  click_button('List space')
end
