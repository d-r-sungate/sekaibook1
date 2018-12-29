module ApplicationHelper
  def page_title
    @page_title = t("title.#{controller.controller_name}.#{controller.action_name}", default: '') if @page_title.nil?
  end
end
