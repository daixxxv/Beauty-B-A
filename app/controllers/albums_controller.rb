class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_album, only: %i[show update destroy]

  def index
    @albums = current_user.albums
                          .includes(album_records: [:before_image_attachment, :after_image_attachment])
                          .order(created_at: :asc)
  end

  def new
    @album = current_user.albums.build
    @album.album_records.build
  end

  def show
    @album_records = @album.album_records
                            .includes(:before_image_attachment, :after_image_attachment)
                            .order(created_at: :asc)

    @before_record = @album.before_record
    @after_record = @album.after_record
  end

  def edit
    @album = current_user.albums
                         .includes(album_records: [:before_image_attachment, :after_image_attachment])
                         .find(params[:id])
  end

  def create
    @album = current_user.albums.build(album_params)

    if @album.save
      redirect_to albums_path, notice: "アルバムを作成しました。"
    else
      @album.album_records.build if @album.album_records.empty?
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @album.update(album_params)
      redirect_to album_path(@album), notice: "アルバムを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album.destroy
    redirect_to albums_path, notice: "アルバムを削除しました。"
  end

  private

  def set_album
    @album = current_user.albums.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :description, :started_on, :before_image, :after_image, :before_record_id, :after_record_id, album_records_attributes: [ :id, :title, :memo, :before_date, :after_date, :before_image, :after_image, :_destroy])
  end
end
