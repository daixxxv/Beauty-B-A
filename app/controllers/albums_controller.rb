class AlbumsController < ApplicationController
  before_action :authenticate_user! # ログイン必須にする場合

  def index
    @albums = Album.all # ※モデルを作成済みの場合は全件取得
  end
end
