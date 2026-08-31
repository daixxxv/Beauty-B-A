class AlbumRecordsController < ApplicationController
    before_action :authenticate_user!
  before_action :set_album
  before_action :set_album_record, only: %i[edit update destroy]

  def new
    @album_record = @album.album_records.build
  end

  def create
    @album_record = @album.album_records.build(album_record_params)

    if @album_record.save
      redirect_to album_path(@album), notice: "B/A を追加しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @album_record.update(album_record_params)
      redirect_to edit_album_path(@album), notice: "B/A を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album_record.destroy
    redirect_to edit_album_path(@album), notice: "B/A を削除しました。"
  end

  private

  def set_album
    @album = current_user.albums.find(params[:album_id])
  end

  def set_album_record
    @album_record = @album.album_records.find(params[:id])
  end

  def album_record_params
    params.require(:album_record).permit(
      :title,
      :memo,
      :before_image,
      :before_date,
      :after_image,
      :after_date
    )
  end
end
