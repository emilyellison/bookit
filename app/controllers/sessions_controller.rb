class SessionsController < ApplicationController

def new
  
end

def create
  user = User.find_by_email(params[:session][:email])
  if user && user.authenticate(params[:session][:password])
    # Sign the user in and redirect to the user's show page.
    sign_in user
    redirect_back_or user
  else
    # Render the sign-in page again.
    flash.now[:error] = 'You\'ve entered an invalid e-mail/password combination.'
    render 'new'
  end
end

def destroy
  sign_out
  redirect_to root_path
end

end
