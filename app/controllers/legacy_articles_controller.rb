class LegacyArticlesController < ApplicationController

  # easiest way to allow programmatic upload
  skip_before_filter :verify_authenticity_token, :only => [:create]
  before_filter :admin_access, :except => [:create]

  # GET /legacy_articles
  # GET /legacy_articles.json
  def index
    if params[:q]
      @legacy_articles = LegacyArticle
        .search(params[:q])
        .sort('publish_at DESC')
        .paginate(:page => params[:page], :per_page => 15)
    else
      @legacy_articles = LegacyArticle
        .all
        .sort('publish_at DESC')
        .paginate(:page => params[:page], :per_page => 15)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @legacy_articles }
    end
  end

  # GET /legacy_articles/1
  # GET /legacy_articles/1.json
  def show
    @legacy_article = LegacyArticle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @legacy_article }
    end
  end

  # GET /legacy_articles/new
  # GET /legacy_articles/new.json
  def new
    @legacy_article = LegacyArticle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @legacy_article }
    end
  end

  # GET /legacy_articles/1/edit
  def edit
    @legacy_article = LegacyArticle.find(params[:id])
  end

  # POST /legacy_articles
  # POST /legacy_articles.json
  def create
    @legacy_article = LegacyArticle.new(params[:legacy_article])

    respond_to do |format|
      if @legacy_article.save
        format.html { redirect_to @legacy_article, notice: 'Legacy article was successfully created.' }
        format.json { render json: @legacy_article, status: :created, location: @legacy_article }
      else
        format.html { render action: "new" }
        format.json { render json: @legacy_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /legacy_articles/1
  # PUT /legacy_articles/1.json
  def update
    @legacy_article = LegacyArticle.find(params[:id])

    respond_to do |format|
      if @legacy_article.update_attributes(params[:legacy_article])
        format.html { redirect_to @legacy_article, notice: 'Legacy article was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @legacy_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /legacy_articles/1
  # DELETE /legacy_articles/1.json
  def destroy
    @legacy_article = LegacyArticle.find(params[:id])
    @legacy_article.destroy

    respond_to do |format|
      format.html { redirect_to legacy_articles_url }
      format.json { head :ok }
    end
  end
end
