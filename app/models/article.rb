class Article < ApplicationRecord
  belongs_to :area
  belongs_to :category
  def self.create_article(page, param, current_user)
    article = Article.find_or_initialize_by(url: param['url'])
    if article.new_record?
      article = Article.create(
        url:      param['url'],
        title:    page.title,
        domain:    page.host,
        description: page.description,
        name:     page.best_title,
        ogpdescription: page.meta['description'],
        ogpimg: page.meta['og:image'],
        favicon: page.images.favicon,
        category_id:  param['category_id'],
        area_id: param['area_id'],
        date: Time.now,
        user_id: current_user.id
        )
    end
    return article
  end
end
