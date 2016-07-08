class MediaFilesController < ApplicationController
  def create
    media = CreateMediaFile.call(params: save_params)
    render json: SerializeMediaFile.to_json(media_file: media)
  end

  def update
  end

  def destroy
  end

  protected

  def save_params
    params.require(:media_file).permit(:file_path, :media_type)
  end
end
