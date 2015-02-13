class DashboardController < ApplicationController

  #new link object and give us most frequently accessed urls based on clicks count
  def index
    @link = Link.new
    @top_urls = Link.order(clicks: :desc).first(100)
  end
end
