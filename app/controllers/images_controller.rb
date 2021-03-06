class ImagesController < ApplicationController
  
  layout :choose_layout
  before_filter :flag_nolayout
  before_filter :member_access

  def new
    @image = Image.new
  end

  def create
    @image = Image.create(params[:image])
    if @image.save
      # @image.picture.reprocess!
      # @image.save
      redirect_to image_path(@image)
    else
      render 'new'
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def show
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    @image.attributes = params[:image]
    if @image.save
      redirect_to image_path(@image)
    else
      render 'edit'
    end
  end

  def index
    if params[:q]
      @images = Image.search(params[:q])
    else
      @images = Image.order('created_at DESC').limit(5)
    end
  end


  private
  
  def choose_layout
    if params[:layout] == 'false'
      "minimal"
    else
      "member"
    end
  end

  def flag_nolayout
    if params[:layout] == 'false'
      @nolayout = true
    end
  end

end
