class ImagesController < ApplicationController
  
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])
    if @image.save
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
      render 'new'
    end
  end

end
