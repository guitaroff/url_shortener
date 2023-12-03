class UrlsController < ApplicationController
  # before_action :find_url, only: [:shortened, :stats]

  # POST /urls
  def create
    url = ShortenedUrl.new(original_url: url_params[:original_url])
    url.save!

    render json: {
      original_url: url.original_url,
      short_url: url.short_url
    }, status: 201
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end
end
