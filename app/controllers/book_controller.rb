class BookController < ApplicationController
  before_action :set_article, only: [:comment]
  before_action :set_or_create_book, only: [:comment, :create, :update]

  def show
  end

  def new
  end

  def create
   if @book.update(book_params)
      redirect_to book_comment_url(@book.article_id), notice: '追加しました。'
    else
      redirect_to book_comment_url(@book.article_id), notice: '追加できませんでした。'
    end
  end

  def update
   if @book.update(book_params)
      redirect_to book_comment_url(@book.article_id), notice: '更新しました。'
    else
      redirect_to book_comment_url(@book.article_id), notice: '更新できませんでした。'
    end
  end

  def add
    @article = Article.new
  end

  def comment
  end
  
  private
    def set_article
      @article = Article.find_by!(id: params[:id])
    end
    def set_or_create_book
      @book = Book.find_or_initialize_by(user_id: current_user.id, article_id: params[:id])
      if @book.new_record?
        @book.comment = ""
      end
    end
    def book_params
      params.require(:book).permit(:comment)
    end
end
