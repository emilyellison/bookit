class UsersController < ApplicationController
  before_filter :signed_in_user,  only: [ :index, :edit, :update ]
  before_filter :correct_user,    only: [ :edit, :update ]
  before_filter :admin_user,      only: :destroy 
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @book_posts = @user.book_posts
    @book_bites = @user.book_bites.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = 'Congrats on becoming a BookBits member!'
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Your profile has been updated."
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'This BookBits Member has been deleted.'
    redirect_to users_path
  end
  
  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  
end
