class ArticlesController < ApplicationController
  def create
    begin
      page = MetaInspector.new(article_params['url'])
      if page != nil then
        article = Article.create_article(page, article_params, current_user)
        if article != nil
          redirect_to books_comment_path(article.id), notice: t('.success')
        else
          redirect_to books_add_url, notice: t('.adderror')
        end
      else
        redirect_to books_add_url, notice: t('.geterror')
      end
    rescue => e
      puts e
      redirect_to books_add_url, notice: t('.geterror')
    end
    
  end
  private
   def article_params
      params.require(:article).permit(:url, :area_id, :category_id)
   end
end
