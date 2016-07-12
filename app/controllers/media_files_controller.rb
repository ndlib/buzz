class MediaFilesController < ApplicationController
  def create
    media = CreateMediaFile.call(params: create_params)
    if media.valid?
      render json: SerializeCompletedCreateAction.to_json(object: media, object_serializer: SerializeMediaFile),
             status: :ok
    else
      render json: SerializeFailedCreateAction.to_json(object: media, object_serializer: SerializeMediaFile),
             status: :unprocessable_entity
    end
  end

  def update
    media = QueryMediaFile.find(uuid: params[:id])
    if UpdateMediaFile.call(media: media, params: update_params)
      render json: SerializeCompletedUpdateAction.to_json(object: media, object_serializer: SerializeMediaFile),
             status: :ok
    else
      render json: SerializeFailedUpdateAction.to_json(object: media, object_serializer: SerializeMediaFile),
             status: :unprocessable_entity
    end
  end

  def destroy
  end

  protected

  def create_params
    params.require(:media_file).permit(:file_path, :media_type)
  end

  def update_params
    params.require(:media_file).permit()
  end
end
