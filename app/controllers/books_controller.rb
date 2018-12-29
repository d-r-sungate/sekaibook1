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
     flashmesg = t('.success')
      if current_user.auto_post_facebook
       
      end
      begin
        twitter_client.update(book_params['comment'].slice(0, Settings.books.tweetlimit))
      rescue => e
        logger.error(e)
        flashmesg = t('.tweeterror')
      end
      redirect_to books_show_url(@book.article_id), notice: flashmesg
    else
      redirect_to books_comment_url(@book.article_id), notice: t('.error')
    end
  end

  def update
   
    if @book.update(book_params)
      flashmesg = t('.success')
      if current_user.auto_post_facebook
       
      end
      if current_user.auto_post_twitter
        begin
          twitter_client.update(book_params['comment'].slice(0, Settings.books.tweetlimit))
        rescue => e
          logger.error(e)
          flashmesg = t('.tweeterror')
        end
      end
      redirect_to books_show_url(@book.article_id), notice: flashmesg
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
    def twitter_client
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = session[:oauth_token]
        config.access_token_secret = session[:oauth_token_secret]
      end
    end
end
