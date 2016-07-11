class MediaFilesController < ApplicationController
  def create
    media = CreateMediaFile.call(params: save_params)
    if media.valid?
      render json: SerializeMediaFile.to_json(object: media)
    else
      render json: SerializeFailedCreateAction.to_json(object: media, object_serializer: SerializeMediaFile),
             status: :unprocessable_entity
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
