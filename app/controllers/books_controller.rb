class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:comment, :create, :update]
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
        set_article
        begin
          facebook_client.put_wall_post(book_params['comment'], {
          "name" => @article.title,
          "link" => @article.url,
          "description" => @article.description,
          "picture" => @article.ogpimg
        })
        rescue => e
          logger.error(e)
          flashmesg = t('.facebookerror')
        end
      end
      if current_user.auto_post_twitter
        set_article
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

  def update
    if @book.update(book_params)
      flashmesg = t('.success')
      if current_user.auto_post_facebook
        set_article
        begin
          facebook_client.put_wall_post(book_params['comment'], {
          "name" => @article.title,
          "link" => @article.url,
          "description" => @article.description,
          "picture" => @article.ogpimg
        })
        rescue => e
          logger.error(e)
          flashmesg = t('.facebookerror')
        end
      end
      if current_user.auto_post_twitter
        set_article
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
    @articlebooks = Book.where(article_id: params[:id]).joins(:user)
  end
  def book_params
    params.require(:book).permit(:comment)
  end
  def twitter_client
    access_token        = session[:oauth_token]
    access_token_secret = session[:oauth_token_secret]
    if current_user.provider != 'twitter'
      if session[:other_oauth_token] == nil || session[:other_oauth_token]['twitter'] == nil
        set_social_profile_token('twitter')
      end
      access_token        = session[:other_oauth_token]['twitter']
      access_token_secret = session[:other_oauth_token_secret]['twitter']
    end
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end
  end
  def facebook_client
    access_token        = session[:oauth_token]
    access_token_secret = session[:oauth_token_secret]
    if current_user.provider != 'twitter'
      access_token        = session[:other_oauth_token]['facebook']
      access_token_secret = session[:other_oauth_token_secret]['facebook']
    end
    Koala.configure do |config|
      config.access_token = access_token
      config.app_access_token = access_token_secret
      config.app_id = ENV['FACEBOOK_APP_ID']
      config.app_secret = ENV['FACEBOOK_APP_SECRET']
    end
    Koala::Facebook::API.new(session[:oauth_token])
  end
  def set_social_profile_token(provider)
    session[:other_oauth_token] = {} unless session[:other_oauth_token]
    session[:other_oauth_token_secret] = {} unless session[:other_oauth_token_secret]
    session[:other_oauth_token][provider] = current_user.get_social_profile_oauth_token(provider)
    session[:other_oauth_token_secret][provider] = current_user.get_social_profile_oauth_token_secret(provider)
  end
end
