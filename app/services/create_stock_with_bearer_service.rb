class CreateStockWithBearerService
  def initialize(params)
    @stock_name = params.dig(:stock, :name)
    @bearer_name = params.dig(:bearer, :name)
  end

  def perform
    stock = Stock.new(name: stock_name)
    bearer = Bearer.find_or_initialize_by(name: bearer_name)
    stock.bearer = bearer

    ApplicationRecord.transaction do
      stock.save
      bearer.save
    end

    return [true, stock] if stock.errors.blank?

    errors = convert_errors(stock)
    [false, errors]
  end

  private

  attr_reader :stock_name, :bearer_name



  def convert_errors(model)
    return {} if model.errors.blank?

    { model.class.name.underscore => model.errors.messages }
  end
end
