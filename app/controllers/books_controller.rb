class BooksController < ApplicationController
  before_action :get_allarticles, only: [:index]
  before_action :set_article, only: [:comment, :show]
  before_action :get_articlebooks, only: [:show]
  before_action :set_or_create_book, only: [:comment, :create, :update]

  def index
  end

  def show
  end

  def create
   if @book.update(book_params)
      redirect_to books_show_url(@book.article_id), notice: t('.success')
    else
      redirect_to books_comment_url(@book.article_id), notice: t('.error')
    end
  end

  def update
   if @book.update(book_params)
      redirect_to books_show_url(@book.article_id), notice: t('.success')
    else
      redirect_to books_comment_url(@book.article_id), notice: t('.error')
    end
  end

  def add
    @article = Article.new
  end

  def comment
  end
  
  private
    def get_allarticles
      @articles = Article.page(params[:page]).per(Settings.books.pagerow)
    end
    def set_article
      @article = Article.find_by!(id: params[:id])
    end
    def set_or_create_book
      @book = Book.find_or_initialize_by(user_id: current_user.id, article_id: params[:id])
      if @book.new_record?
        @book.comment = ""
      end
    end
    def get_articlebooks
      @articlebooks = Book.where(article_id: params[:id])
    end
    def book_params
      params.require(:book).permit(:comment)
    end
end
