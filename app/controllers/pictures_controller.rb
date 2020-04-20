class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
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
  end
  def edit
  end
  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "Pictureを編集しました！"
    else
      render :edit
    end
  end
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: "Pictureを削除しました！"
  end
  private
    def picture_params
      params.require(:picture).permit(:title, :content)
    end
    def set_picture
      @picture = Picture.find(params[:id])
    end
end
