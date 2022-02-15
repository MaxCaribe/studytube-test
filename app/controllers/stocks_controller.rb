class StocksController < ApplicationController
  def index
    stocks = Stock.all.includes(:bearer)

    render json: serialize(stocks)
  end

  def create
    success, data = CreateStockWithBearerService.new(params).perform

    if success
      render json: serialize(data)
    else
      render json: data, status: 422
    end
  end

  def update
    stock = Stock.find(params[:id])
    success, data = UpdateStockService.new(stock, params).perform

    if success
      render json: serialize(data)
    else
      render json: data, status: 422
    end
  end

  def destroy
    stock = Stock.find(params[:id])
    stock.destroy

    render json: {}
  end

  private

  def serialize(stock, options: { include: [:bearer] })
    StockSerializer.new(stock, options).serializable_hash.to_json
  end
end
