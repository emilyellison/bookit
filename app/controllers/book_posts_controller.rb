class BookPostsController < ApplicationController
  before_filter :signed_in_user,  only: [:create, :destroy]
  before_filter :correct_user,    only: :destroy

  def create
    @book_post = current_user.book_posts.build(params[:book_post])
    if @book_post.save
      flash[:success] = 'Your book post has been created!'
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @book_post.destroy
    redirect_back_or root_path
  end
  
  private
  
    def correct_user
      @book_post = current_user.book_posts.find_by_id(params[:id])
      redirect_to root_path if @book_post.nil?
    end
  
end