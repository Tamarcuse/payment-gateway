require_relative 'base'

module Chargers
  class Visa < Base
    CHARGE_URL = 'https://interview.riskified.com/visa/api/chargeCard'.freeze
    CHARGE_RESULT = 'chargeResult'.freeze
    SUCCESS = 'Success'.freeze

    def charge
      puts "Visa Charge.."
      res = RestClient.post(CHARGE_URL, payload, headers)
      puts "Visa res: #{res}"
      handle_response(res)
    end

    private

    def handle_response(res)
      res_body = JSON.parse(res.body)
      successful_charge = res.code == OK_STATUS && res_body[CHARGE_RESULT] == SUCCESS
      puts "MasterCard success? #{successful_charge}"
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
