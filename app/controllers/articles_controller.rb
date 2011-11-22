class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if current_user
      @article.user = current_user
    end
    if @article.save
      flash.now.notice = "Article saved successfully"
      redirect_to user_path(current_user)
    else
      flash.now.alert = "Unable to save article"
      render "new"
    end
  end

  def show
    @article = Article.find(params[:id])
    @youtube_transformer = lambda do |env|
      node      = env[:node]
      node_name = env[:node_name]

      # Don't continue if this node is already whitelisted or is not an element.
      return if env[:is_whitelisted] || !node.element?
      
      # Don't continue unless the node is an iframe.
      return unless node_name == 'iframe'
      
      # Verify that the video URL is actually a valid YouTube video URL.
      return unless node['src'] =~ /\Ahttps?:\/\/(?:www\.)?youtube(?:-nocookie)?\.com\//
      
      # We're now certain that this is a YouTube embed, but we still need to run
      # it through a special Sanitize step to ensure that no unwanted elements or
      # attributes that don't belong in a YouTube embed can sneak in.
      Sanitize.clean_node!(node, {
                             :elements => %w[iframe],
                             
                             :attributes => {
                               'iframe'  => %w[allowfullscreen frameborder height src width]
                             }
                           })
      
      # Now that we're sure that this is a valid YouTube embed and that there are
      # no unwanted elements or attributes hidden inside it, we can tell Sanitize
      # to whitelist the current node.
      {:node_whitelist => [node]}
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash.now.notice = "Article saved successfully"
      redirect_to article_path(@article)
    else
      flash.now.alert = "Unable to save article"
      render "edit"
    end
  end

end
