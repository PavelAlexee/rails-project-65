module Web::BreadcrumbsHelper
  def breadcrumb(links = [])
    content_for(:breadcrumbs) do
      render "layouts/shared/breadcrumbs", links: links
    end
  end

  def render_breadcrumbs
    render "layouts/shared/breadcrumbs", links: breadcrumbs_links if content_for?(:breadcrumbs)
  end

  def breadcrumbs_links
    @breadcrumbs_links ||= []
  end

  def add_breadcrumb(name, path = nil)
    breadcrumbs_links << { name: name, path: path }
  end
end
