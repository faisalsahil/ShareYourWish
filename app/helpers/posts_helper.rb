module PostsHelper
  include ActsAsTaggableOn::TagsHelper
  def link_to_unless_current_posts_category(posts_category, html_options = {}, &block)
    if posts_category.present? && params[:posts_category_id].present? && params[:posts_category_id].eql?(posts_category.slug)
      posts_category.name
    else
      link_to(posts_category.name, posts_category_path(posts_category), html_options, &block)
    end
  end
end
