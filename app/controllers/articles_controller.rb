class ArticlesController < ApplicationController
  def create
    begin
      page = MetaInspector.new(article_params['url'])
      if page != nil then
        if Article.create_article(page, article_params, current_user)
          redirect_to book_add_url, notice: '追加しました。'
        else
          redirect_to book_add_url, notice: '追加できませんでした。'
        end
      else
        redirect_to book_add_url, notice: '取得できませんでした。'
      end
    rescue => e
      puts e
      redirect_to book_add_url, notice: '取得できませんでした。'
    end
    
  end
  private
   def article_params
      params.require(:article).permit(:url, :area_id, :category_id)
    end
end
