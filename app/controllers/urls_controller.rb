class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.all
  end

  def create
    @url = Url.new(url_params)
    @url.shortened_url = random_code
    @url.save!
    # TODO: rescue
    redirect_to root_path, notice: 'Short url successfully created!'
  end

  def get
    
  end

  def show
  end

  def destroy
  end

  private
    def url_params
      params.require(:url).permit(:original_url)
    end

    def random_code
      existing_codes = Url.select(:shortened_url).map(&:shortened_url)
      new_code = [*('A'..'Z'),*('0'..'9')].shuffle[0,4].join

      while existing_codes.include?(new_code)
        new_code = [*('A'..'Z'),*('0'..'9')].shuffle[0,4].join
      end

      new_code
    end
end
