class ChargesController < ApplicationController
  before_action :validate_request

  MERCHANT_IDENTIFIER = 'merchant-identifier'.freeze
  VALIDATIONS = %w[validate_headers validate_body].freeze

  BODY_PARAMS = [
    { label: 'fullName', type: String },
    { label: 'creditCardNumber', type: String },
    { label: 'creditCardCompany', type: String },
    { label: 'expirationDate', type: String },
    { label: 'cvv', type: String },
    { label: 'amount', type: Float }
  ].freeze

  def create
    render json: { status: 'OK' }, status: 200
  end

  private

  def validate_request
    VALIDATIONS.each do |validation|
      render json: {}, status: :bad_request and return unless send(validation)
    end
  end

  def validate_headers
    request.headers[MERCHANT_IDENTIFIER].is_a? String
  end

  def validate_body
    BODY_PARAMS.each do |param|
      return unless params[param[:label]].is_a? param[:type]
    end
    true
  end

end
