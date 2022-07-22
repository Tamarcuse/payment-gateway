require '/Users/tamir/workspace/payment-gateway-simulation/Ruby on Rails/app/presenters/error_counter'

class ChargeStatusesController < ApplicationController
  MERCHANT_IDENTIFIER = 'merchant-identifier'.freeze

  def index
    render json: error_counters.map do |error_counter|
      ::Presenters::ErrorCounterPresenter.new(error_counter)
    end
  end

  private

  def error_counters
    ErrorCounter.where(merchant: merchant).all
  end

  def merchant
    request.headers[MERCHANT_IDENTIFIER]
  end

end
