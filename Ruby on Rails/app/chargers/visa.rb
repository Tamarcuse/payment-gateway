require_relative 'base'

module Chargers
  class Visa < Base
    CHARGE_URL = 'https://interview.riskified.com/visa/api/chargeCard'.freeze
    CHARGE_RESULT = 'chargeResult'.freeze
    SUCCESS = 'Success'.freeze

    def charge
      super(CHARGE_URL, payload, headers)
    end

    private

    def handle_response(res)
      res_body = JSON.parse(res.body)
      successful_charge = res.present? && res.code == OK_STATUS && res_body[CHARGE_RESULT] == SUCCESS
      successful_charge ? success_result : failure_result
    end

    def headers
      {
        "identifier": identifier
      }
    end

    def payload
      {
        fullName: full_name,
        number: card_number,
        expiration: expiration_date,
        cvv: cvv,
        totalAmount: amount
      }
    end

  end
end
