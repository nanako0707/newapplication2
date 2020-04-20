class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
  end
  def new
    @picture = Picture.new
  end
  def create
    @picture = Picture.create(picture_params)
    if @picture.save
      redirect_to pictures_path, notice: "Pictureを作成しました！"
    else
      render :new
    end
  end
  def show
    @picture = Picture.find(params[:id])
  end
  def edit
    @picture = Picture.find(params[:id])
  end
  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "Pictureを編集しました！"
    else
      render :edit
    end
  end
  private
    def picture_params
      params.require(:picture).permit(:title, :content)
    end
end
