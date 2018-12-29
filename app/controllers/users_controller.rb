
class UsersController < ApplicationController
   before_action :set_user, only: [:show, :edit, :update]
   before_action :set_current_user
   before_action :get_books, only: [:show]
  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
        redirect_to user_url, notice: t('.success')
     else
       render 'edit'
     end
  end
  
 private
  def user_params
     params.require(:user).permit(:username, :oganization, :title, :introduction, :country, :auto_post_facebook, :auto_post_twitter)
   end
  def set_user
    @user = User.find(params[:id])
  end
  def get_books
    @books = Book.where(user_id: params[:id]).page(params[:page]).per(Settings.users.books.pagerow)
  end
end
