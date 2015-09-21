class PostsController < ApplicationController
  load_and_authorize_resource
  before_filter :redirect_unless_admin, :except => [:show, :index, :feed]

  def index
    if params[:posts_category_id].present?
      @posts_category = PostsCategory.find(params[:posts_category_id])
      @posts = @posts_category ? @posts_category.posts.paginate(:page => params[:page]) : Post.paginate(:page => params[:page])
    elsif params[:tag_id].present?
      @tag = params[:tag_id]
      @posts = Post.tagged_with(@tag).paginate(:page => params[:page])
    else
      @posts = Post.paginate(:page => params[:page])
    end

    @posts_categories = PostsCategory.all
    @tags = Post.tag_counts_on(:tags).limit(8)
  end
  
  def tags
    @posts_categories = PostsCategory.all
    @tags = Post.tag_counts_on(:tags)
  end

  def show
    @post = Post.find(params[:post_id]) || not_found
    @posts_category = @post.posts_category
    @posts = @posts_category.posts
    @comment = @post.comments.build
    @posts_categories = PostsCategory.all
  end

  def feed
    @title = "Share Your Wish - Our Blog"
    @posts = Post.by_updated
    @updated = @posts.first.updated_at unless @posts.empty?
    respond_to do |format|
      format.atom { render :layout => false }
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

end

