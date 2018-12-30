class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @book = Book.find(params[:book_id])
    unless @book.like?(current_user)
      @book.createlike(current_user)
      @book.reload
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @book = Like.find(params[:id]).book
    if @book.like?(current_user)
      @book.dellike(current_user)
      @book.reload
      respond_to do |format|
        format.js
      end
    end
  end

  private
end
