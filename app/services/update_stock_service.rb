class UpdateStockService
  def initialize(stock, params)
    @stock = stock
    @stock_name = params[:name]
  end

  def perform
    ApplicationRecord.transaction do
      stock.update(name: stock_name)
    end

    stock.errors.blank? ? [true, stock] : [false, stock.errors.messages]
  end

  private

  attr_reader :stock, :stock_name
end
