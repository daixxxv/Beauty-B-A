class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def index
    @albums = current_user.albums
  end

  def new
    @album = Album.new
  end

  def show
    @album = current_user.albums.find(params[:id])
    # @album = current_user.albums.includes(:records).find(params[:id])記録機能作ったらこっちに直す

    # @before_record = @album.before_record
    # @after_record = @album.after_record
  end

  def edit
    @album = current_user.albums.find(params[:id])
  end

  def create
    @album = current_user.albums.build(album_params)

    if @album.save
      redirect_to albums_path, notice: "アルバムを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @album = current_user.albums.find(params[:id])

    if @album.update(album_params)
      redirect_to album_path(@album), notice: "アルバムを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album = current_user.albums.find(params[:id])
    @album.destroy

    redirect_to albums_path, notice: "アルバムを削除しました。"
  end

  private

  def album_params
    params.require(:album).permit(:title, :description, :started_on)
  end
end
