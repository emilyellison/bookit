def sign_in(user)
  visit signin_path
  fill_in "E-mail",   with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
  cookies[:remember_token] = user.remember_token
end  