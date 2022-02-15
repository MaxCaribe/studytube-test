require 'rails_helper'

describe CreateStockWithBearerService do
  subject { described_class.new(params).perform }

  let(:stock) { FactoryBot.build(:stock) }
  let(:bearer) { FactoryBot.build(:bearer) }
  let(:params) { { stock: { name: stock.name }, bearer: { name: bearer.name } } }

  context 'when uniq stock name' do
    context 'when new bearer' do
      it 'is successful' do
        success, _ = subject

        expect(success).to be_truthy
      end

      it 'saves stock' do
        _, stock = subject

        expect(stock.persisted?).to be_truthy
      end

      it 'saves bearer' do
        _, stock = subject

        expect(stock.bearer.persisted?)
      end
    end

    context 'when persisted bearer' do
      before { bearer.save }

      it 'is successful' do
        success, _ = subject

        expect(success).to be_truthy
      end

      it 'saves stock' do
        _, stock = subject

        expect(stock.persisted?).to be_truthy
      end

      it 'uses saved bearer' do
        _, stock = subject

        expect(stock.bearer.id).to eq(bearer.id)
      end
    end
  end

  context 'when not uniq stock name' do
    before do
      bearer.save
      stock.update(bearer_id: bearer.id)
    end

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
