require 'rest-client'

class HealthcheckController < ApplicationController
  MOCK_SERVER_URL = 'https://interview.riskified.com'.freeze

  def index
    mock_server_response = RestClient.get("#{MOCK_SERVER_URL}/healthcheck", nil)
    puts("Mock server responded to health check with the following response: #{mock_server_response.body}")

    render json: { status: 'OK' }, status: 200
  end
end
