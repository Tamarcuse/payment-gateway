require '/Users/tamir/workspace/payment-gateway-simulation/Ruby on Rails/app/validators/charge'
require '/Users/tamir/workspace/payment-gateway-simulation/Ruby on Rails/app/chargers/context'

class ChargesController < ApplicationController
  before_action :validate_request

  CHARGE_PARAMS = %i[fullName creditCardNumber creditCardCompany expirationDate cvv amount].freeze
  CARD_DECLINED = 'CARD_DECLINED'.freeze

  def create
    res = ::Chargers::Context.charge(data: charge_data)

    if res.success?
      render json: {}, status: 200
    else
      render json: { error: CARD_DECLINED}, status: 200
    end
  end

  private

  def validate_request
    render json: {}, status: :bad_request and return unless valid_request?
  end

  def valid_request?
    ::Validators::Charge.validate(
      headers: request.headers,
      params: params
    )
  end

  def charge_data
    {
      identifier: request.headers['merchant-identifier'],
      full_name: params['fullName'],
      card_number: params['creditCardNumber'],
      card_company: params['creditCardCompany'],
      expiration_date: params['expirationDate'],
      cvv: params['cvv'],
      amount: params['amount']
    }
  end

end
