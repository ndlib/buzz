class HealthcheckController < ApplicationController
  def index
    lastCheck = HealthCheck.first_or_create
    lastUpdate = lastCheck.updated_at
    lastCheck.touch
    render json: { status: "ok", lastCheck: lastUpdate }, status: :ok
  end
end
