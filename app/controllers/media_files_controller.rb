class MediaFilesController < ApplicationController
  def create
    media = CreateMediaFile.call(params: save_params)
    if media.valid?
      render json: SerializeMediaFile.to_json(media_file: media)
    else
      render_validation_errors object: media
    end
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
