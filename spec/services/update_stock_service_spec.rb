require 'rails_helper'

describe UpdateStockService do
  subject { described_class.new(stock, params).perform }

  let(:stock) { FactoryBot.create(:stock, :with_bearer) }
  let(:new_stock) { FactoryBot.build(:stock) }
  let(:params) { { name: new_stock.name } }

  context 'when new uniq stock name' do

    it 'is successful' do
      success, _ = subject

      expect(success).to be_truthy
    end

    it 'updates name' do
      _, updated_stock = subject

      expect(updated_stock.name).to eq(new_stock.name)
    end

    it 'is updated stock' do
      _, updated_stock = subject

      expect(updated_stock.id).to eq(stock.id)
    end
  end

  context 'when not uniq stock name' do
    before { new_stock.update(bearer_id: stock.bearer.id) }

    it 'is failure' do
      success, _ = subject

      expect(success).to be_falsey
    end

    it 'has one error' do
      _, errors = subject

      expect(errors.size).to eq(1)
    end
  end
end
