require_relative 'base'

module Chargers
  class MasterCard < Base

    CHARGE_URL = 'https://interview.riskified.com/mastercard/capture_card'.freeze

    def charge
      res = RestClient.post(CHARGE_URL, payload, headers)
      puts "MasterCard res: #{res.inspect}"
      handle_response(res)
    end

    private

    def handle_response(res)
      puts "MasterCard success? #{res.code == OK_STATUS}"
      res.code == OK_STATUS ? success_result : failure_result
    end

    def headers
      {
        "identifier": identifier
      }
    end

    def payload
      {
        first_name: first_name,
        last_name: last_name,
        card_number: card_number,
        expiration: master_card_expiration,
        cvv: cvv,
        charge_amount: amount
      }
    end

    def master_card_expiration
      expiration_date.gsub('/', '-')
    end

  end
end
