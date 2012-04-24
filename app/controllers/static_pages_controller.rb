class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @book_post = current_user.book_posts.build
      @book_post_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
end
