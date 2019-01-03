module ApplicationHelper
  def page_title
    @page_title = t("title.#{controller.controller_name}.#{controller.action_name}", default: '') if @page_title.nil?
  end
  
  def country_name(country_cd)
    country = ISO3166::Country[country_cd]
    if country != nil
      country.translations[I18n.locale.to_s] || country.name
    end
  end
def site_name(name)
  name.gsub(/(\["|"\])/, '')
end
end
