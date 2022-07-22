module Validators
  class Charge
    attr_reader :headers, :params

    MERCHANT_IDENTIFIER = 'merchant-identifier'.freeze
    VALIDATIONS = %w[validate_headers validate_body].freeze

    BODY_PARAMS = [
      { label: 'fullName', validation_method: 'is_a_string?' },
      { label: 'creditCardNumber', validation_method: 'is_a_string?' },
      { label: 'creditCardCompany', validation_method: 'valid_card_company?' },
      { label: 'expirationDate', validation_method: 'valid_expiration?' },
      { label: 'cvv', validation_method: 'is_a_string?' },
      { label: 'amount', validation_method: 'is_a_float?' }
    ].freeze

    VALID_CARD_COMPANIES = %w[visa mastercard].freeze
    VALID_DATE_FORMAT = /\d{2}\/\d{2}/.freeze

    def self.validate(headers:, params:)
      new(
        headers: headers,
        params: params
      ).validate
    end

    def initialize(headers:, params:)
      @headers = headers
      @params = params
    end

    def validate
      VALIDATIONS.each do |validation|
        return false unless send(validation)
      end
      true
    end

    def validate_headers
      headers[MERCHANT_IDENTIFIER].is_a? String
    end

    def validate_body
      BODY_PARAMS.each do |param|
        param_value = params[param[:label]]
        return false unless send(param[:validation_method], param_value)
      end
      true
    end

    def is_a_string?(value)
      value.is_a? String
    end

    def is_a_float?(value)
      value.is_a? Float
    end

    def valid_card_company?(company)
      is_a_string?(company) && VALID_CARD_COMPANIES.include?(company)
    end

    def valid_expiration?(expiration)
      is_a_string?(expiration) && expiration.match(VALID_DATE_FORMAT)
    end

  end
end