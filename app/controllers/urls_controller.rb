class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.all
  end

  def create
    @url = Url.new(url_params)
    @url.shortened_url = random_code if @url.shortened_url.blank?
    @url.save!
    redirect_to root_path, notice: "Short url successfully created! Here: #{request.base_url}/#{@url.shortened_url}"
  rescue StandardError => e
    flash[:error] = "Oops! #{e}"
    redirect_to root_path
  end

  def get
    url = Url.find_by!(shortened_url: params[:code])
    url.count += 1
    url.save!
    redirect_to url.original_url
  rescue StandardError
    flash[:error] = "That's not right. Did you mistype the url?"
    redirect_to root_path
  end

  def show
    url = Url.find(params[:id].to_i)
    @stats = {
      shortened_url: "#{request.base_url}/#{url.shortened_url}",
      original_url: url.original_url,
      usage_count: url.count,
      created_at: url.created_at,
      most_recent_use: url.updated_at
    }
  end

  private
    def url_params
      params.require(:url).permit(:original_url, :shortened_url)
    end

    def random_code
      existing_codes = Url.select(:shortened_url).map(&:shortened_url)
      new_code = [*('A'..'Z'),*('0'..'9')].shuffle[0,4].join

      while existing_codes.include?(new_code)
        new_code = [*('A'..'Z'), *('0'..'9')].shuffle[0,4].join
      end

      new_code
    end
end
