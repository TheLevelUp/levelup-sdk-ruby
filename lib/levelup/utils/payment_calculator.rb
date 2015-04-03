module Levelup
  module Utils
    # This is a tool to allow integrators to calculate various values to discount and tender
    class PaymentCalculator
      # @param discount_applied [Integer] The total LevelUp discount applied to the check.
      # @param gift_card_credit_available [Integer] The total available amount of LevelUp gift card
      #   credit.
      # @param spend_amount_returned_from_levelup [Integer] The amount of spend returned from the
      #   LevelUp API.
      # @param tip_returned_from_levelup [Integer] The tip returned from the LevelUp API.
      def initialize(discount_applied:, gift_card_credit_available:,
          spend_amount_returned_from_levelup:, tip_returned_from_levelup:)
        @discount_applied = discount_applied
        @gift_card_credit_available = gift_card_credit_available
        @spend_amount_returned_from_levelup = spend_amount_returned_from_levelup
        @tip_returned_from_levelup = tip_returned_from_levelup
      end

      # Calculates the LevelUp discount to apply based on the arguments passed
      # @param check_total_due_including_tax [Integer] Grand total of check balance in cents
      # @param exempted_item_total [Integer] Combined total of exempted items in cents
      # @param merchant_funded_credit_available [Integer] Total amount of merchant funded credit
      #   available in cents
      # @param payment_amount_requested [Integer] Spend amount requested from LevelUp API order
      #   endpoint in cents
      # @param tax_amount_due [Integer] Total amount of tax due on the check
      def self.levelup_discount_to_apply(check_total_due_including_tax:, exempted_item_total:,
          merchant_funded_credit_available:, payment_amount_requested:, tax_amount_due:)
        total_due_without_tax = check_total_due_including_tax - tax_amount_due
        max_discount = [payment_amount_requested, total_due_without_tax].min
        max_discount_less_exemptions = [0,  max_discount - exempted_item_total].max
        [merchant_funded_credit_available, max_discount_less_exemptions].min
      end

      # Cent amount of LevelUp gift card payment to apply NOT including tip
      def gift_card_payment_to_apply
        [spend_amount_after_discount, @gift_card_credit_available].min
      end

      # Remaining balance in cents on LevelUp gift card after gift card payment has been applied
      def gift_card_remaining_balance_after_payment
        [0, @gift_card_credit_available - total_gift_card_payment_to_apply_including_tip].max
      end

      # Cent amount of LevelUp gift card tip to apply NOT including LevelUp gift card payment
      def gift_card_tip_to_apply
        total_gift_card_payment_to_apply_including_tip - gift_card_payment_to_apply
      end

      # Cent amount of LevelUp payment to apply NOT including the tip amount
      def levelup_payment_to_apply
        [0, spend_amount_after_discount - @gift_card_credit_available].max
      end

      # Cent amount of LevelUp tip to apply NOT including payment amount
      def levelup_tip_to_apply
        total_levelup_payment_to_apply_including_tip - levelup_payment_to_apply
      end

      # Total amount in cents of LevelUp payment to apply including both tip AND payment amounts
      def total_levelup_payment_to_apply_including_tip
        [0, total_amount_after_discount - @gift_card_credit_available].max
      end

      private

      # Spend amount in cents after discount is subtracted
      def spend_amount_after_discount
        [0, @spend_amount_returned_from_levelup - @discount_applied].max
      end

      # Total amount in cents including tip after discount is subtracted
      def total_amount_after_discount
        spend_amount_after_discount + @tip_returned_from_levelup
      end

      # Total amount in cents of LevelUp gift card payment to apply including tip
      def total_gift_card_payment_to_apply_including_tip
        [total_amount_after_discount, @gift_card_credit_available].min
      end
    end
  end
end
