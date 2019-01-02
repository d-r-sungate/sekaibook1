class Article < ApplicationRecord
  belongs_to :area
  belongs_to :category
  validates :url,    length: { maximum: 191 }
  def self.create_article(page, param, current_user)
    article = Article.find_or_initialize_by(url: param['url'])
    if article.new_record?
      if page.meta_tags['property']['og:site_name'] != nil && page.meta_tags['property']['og:site_name'] != ""
       site_name = page.meta_tags['property']['og:site_name']
      elsif page.author != nil && page.author != ""
         site_name = page.author
      elsif page.meta_tags['property']['twitter:site'] != nil && page.meta_tags['property']['twitter:site'] != ""
           site_name = page.meta_tags['property']['twitter:site']
      else
        site_name = page.best_title
      end
      article = Article.create(
        url:      param['url'],
        title:    page.best_title,
        domain:    page.host,
        description: page.description,
        name:     site_name,
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
