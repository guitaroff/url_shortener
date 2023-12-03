class UrlsController < ApplicationController
  before_action :find_url, only: [:shortened, :stats]

  # POST /urls
  def create
    url = ShortenedUrl.new(original_url: url_params[:original_url])
    url.save!

    render json: {
      original_url: url.original_url,
      short_url: url.short_url
    }, status: 201
  end

  # GET /urls/short_url/stats
  def stats
    render json: { view_count: @url.view_count }
  end

  # GET /urls/short_url
  def shortened
    ShortenedUrl.update_counters(@url.id, view_count: 1)
    @url.reload

    url_info = {
      original_url: @url.original_url,
      short_url: @url.short_url
    }

    render json: url_info
  end

  private

  def find_url
    @url = ShortenedUrl.find_by!(short_url: params[:short_url])
  end

  def url_params
    params.require(:url).permit(:original_url)
  end
end
