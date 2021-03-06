require 'elasticsearch'

class CompetitorPricesController < ApplicationController
  before_action :set_competitor_price, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /competitor_prices
  # GET /competitor_prices.json
  def index
    @competitor_prices = CompetitorPrice.all
  end

  # GET /competitor_prices/1
  # GET /competitor_prices/1.json
  def show
    render json: @competitor_price
  end

  # GET /competitor_prices/new
  def new
    @competitor_price = CompetitorPrice.new
  end

  # GET /competitor_prices/1/edit
  def edit
  end

  # POST /competitor_prices
  # POST /competitor_prices.json
  def create
    client = Elasticsearch::Client.new host: "http://#{ENV['ES_HOST']}:9200"
    product_name = competitor_price_params[:title]
    query =  { "_source": ["title", "price","store_id","product_id","store_name","imageurl","size","url","updated_at","status","currency"], "query":{ "match":{ "title":{"query":product_name} } } }
    es_response =client.search index: 'honestbee', body: query
    
    #es_response =client.search index: 'honestbee', body: { "_source": ["title", "price","store_id","product_id","store_name","imageurl","size","url","updated_at","status","currency"], "query":{ "match":{ "title":{"query":test} } } }
    #Array
    @data = es_response['hits']['hits'].map { |r| r['_source']}
    @competitor_price = CompetitorPrice.new(competitor_price_params)
    if @competitor_price.save
      render :json => @data
    else
    end
    #respond_to do |format|
    #  if @competitor_price.save
    #    render :json => @data
    #    #format.json { render :json => @data }
    #    #format.html { redirect_to @data, notice: 'Competitor price was successfully created.' }
    #    #format.json { render :show, status: :created, location: @competitor_price }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @competitor_price.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /competitor_prices/1
  # PATCH/PUT /competitor_prices/1.json
  def update
    respond_to do |format|
      if @competitor_price.update(competitor_price_params)
        format.html { redirect_to @competitor_price, notice: 'Competitor price was successfully updated.' }
        format.json { render :show, status: :ok, location: @competitor_price }
      else
        format.html { render :edit }
        format.json { render json: @competitor_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitor_prices/1
  # DELETE /competitor_prices/1.json
  def destroy
    @competitor_price.destroy
    respond_to do |format|
      format.html { redirect_to competitor_prices_url, notice: 'Competitor price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_competitor_price
      @competitor_price = CompetitorPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competitor_price_params
      params.require(:competitor_price).permit(:imageurl, :price, :source, :title, :update_at, :url)
    end
end
