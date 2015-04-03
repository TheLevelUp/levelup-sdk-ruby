require 'spec_helper'

describe 'Utils::PaymentCalculator::Calculate' do
  describe '#calculate_levelup_discount_to_apply' do
    context 'with merchant_funded_credit_available and no exemptions' do
      it 'returns the proper amount of credit to apply' do
        calculator = Levelup::Utils::PaymentCalculator.levelup_discount_to_apply(
          check_total_due_including_tax: 110,
          exempted_item_total: 0,
          merchant_funded_credit_available: 50,
          payment_amount_requested: 100,
          tax_amount_due: 10
        )
        expect(calculator).to eq(50)
      end
    end

    context 'with merchant_funded_credit_available with overriding exemptions' do
      it 'returns the proper credit to apply minus exemptions' do
        calculator = Levelup::Utils::PaymentCalculator.levelup_discount_to_apply(
          check_total_due_including_tax: 110,
          exempted_item_total: 80,
          merchant_funded_credit_available: 50,
          payment_amount_requested: 100,
          tax_amount_due: 10
        )
        expect(calculator).to eq(20)
      end
    end

    context 'with no merchant_funded_credit_available' do
      it 'returns no credit to apply' do
        calculator = Levelup::Utils::PaymentCalculator.levelup_discount_to_apply(
          check_total_due_including_tax: 110,
          exempted_item_total: 80,
          merchant_funded_credit_available: 0,
          payment_amount_requested: 100,
          tax_amount_due: 10
        )
        expect(calculator).to eq(0)
      end
    end

    context 'with more merchant_funded_credit available than amount due' do
      it 'returns the max allowable mfc amount' do
         calculator = Levelup::Utils::PaymentCalculator.levelup_discount_to_apply(
          check_total_due_including_tax: 110,
          exempted_item_total: 0,
          merchant_funded_credit_available: 500,
          payment_amount_requested: 100,
          tax_amount_due: 10
        )
        expect(calculator).to eq(100)
      end
    end
  end

  describe '#calculate_tenders_and_tips' do
    context 'with discount' do
      it 'returns the proper tenders and values' do
        calculator = Levelup::Utils::PaymentCalculator.new(
          discount_applied: 1000,
          gift_card_credit_available: 0,
          spend_amount_returned_from_levelup: 1000,
          tip_returned_from_levelup: 0
        )
        expect(calculator.gift_card_payment_to_apply).to be(0)
        expect(calculator.gift_card_tip_to_apply).to be(0)
        expect(calculator.levelup_payment_to_apply).to be(0)
        expect(calculator.levelup_tip_to_apply).to be(0)
      end
    end

    context 'with discount and gift card with tip' do
      it 'returns the proper tenders and values' do
        calculator = Levelup::Utils::PaymentCalculator.new(
          discount_applied: 500,
          gift_card_credit_available: 1000,
          spend_amount_returned_from_levelup: 1000,
          tip_returned_from_levelup: 500
        )
        expect(calculator.gift_card_payment_to_apply).to be(500)
        expect(calculator.gift_card_tip_to_apply).to be(500)
        expect(calculator.levelup_payment_to_apply).to be(0)
        expect(calculator.levelup_tip_to_apply).to be(0)
      end
    end

    context 'with discount and gift card and levelup tender' do
      it 'returns the proper tenders and values' do
        calculator = Levelup::Utils::PaymentCalculator.new(
          discount_applied: 500,
          gift_card_credit_available: 1000,
          spend_amount_returned_from_levelup: 1000,
          tip_returned_from_levelup: 500
        )
        expect(calculator.gift_card_payment_to_apply).to be(500)
        expect(calculator.gift_card_tip_to_apply).to be(500)
        expect(calculator.levelup_payment_to_apply).to be(0)
        expect(calculator.levelup_tip_to_apply).to be(0)
      end
    end

    context 'with discount, gift card, levelup tender and levelup tip' do
      it 'returns the proper tenders and values' do
        calculator = Levelup::Utils::PaymentCalculator.new(
          discount_applied: 50,
          gift_card_credit_available: 60,
          spend_amount_returned_from_levelup: 150,
          tip_returned_from_levelup: 50
        )
        expect(calculator.gift_card_payment_to_apply).to be(60)
        expect(calculator.gift_card_tip_to_apply).to be(0)
        expect(calculator.levelup_payment_to_apply).to be(40)
        expect(calculator.levelup_tip_to_apply).to be(50)
      end
    end

    context 'with gift card, levelup tender' do
      it 'returns the proper tenders and values' do
        calculator = Levelup::Utils::PaymentCalculator.new(
          discount_applied: 0,
          gift_card_credit_available: 500,
          spend_amount_returned_from_levelup: 1000,
          tip_returned_from_levelup: 0
        )
        expect(calculator.gift_card_payment_to_apply).to be(500)
        expect(calculator.gift_card_tip_to_apply).to be(0)
        expect(calculator.levelup_payment_to_apply).to be(500)
        expect(calculator.levelup_tip_to_apply).to be(0)
      end
    end

    context 'with gift card, levelup tender and levelup tip' do
      it 'returns the proper tenders and values' do
        calculator = Levelup::Utils::PaymentCalculator.new(
          discount_applied: 0,
          gift_card_credit_available: 500,
          spend_amount_returned_from_levelup: 1000,
          tip_returned_from_levelup: 500
        )
        expect(calculator.gift_card_payment_to_apply).to be(500)
        expect(calculator.gift_card_tip_to_apply).to be(0)
        expect(calculator.levelup_payment_to_apply).to be(500)
        expect(calculator.levelup_tip_to_apply).to be(500)
      end
    end

    context 'with levelup tender and levelup tip' do
      it 'returns the proper tenders and values' do
        calculator = Levelup::Utils::PaymentCalculator.new(
          discount_applied: 500,
          gift_card_credit_available: 0,
          spend_amount_returned_from_levelup: 2000,
          tip_returned_from_levelup: 500
        )
        expect(calculator.gift_card_payment_to_apply).to be(0)
        expect(calculator.gift_card_tip_to_apply).to be(0)
        expect(calculator.levelup_payment_to_apply).to be(1500)
        expect(calculator.levelup_tip_to_apply).to be(500)
      end
    end
  end
end
