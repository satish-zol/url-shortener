class LinksController < ApplicationController
  before_action :set_link, only: [:show, :create]

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
    #if enter the short url, will redirect to original url and clicks will increase by 1
    if params[:slug]
      @link = Link.find_by_slug(params[:slug])
      if redirect_to @link.given_url
        @link.clicks += 1
        @link.save
      end
    else
      @link = Link.find(params[:id])
    end
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  # def edit
  # end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  # def update
  #   respond_to do |format|
  #     if @link.update(link_params)
  #       format.html { redirect_to @link, notice: 'Link was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @link }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @link.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /links/1
  # DELETE /links/1.json
  # def destroy
  #   @link.destroy
  #   respond_to do |format|
  #     format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find_by_slug(params[:slug])
      @top_urls = Link.order(clicks: :desc).first(100) #top urls based on clicks count
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:given_url)
    end
end
