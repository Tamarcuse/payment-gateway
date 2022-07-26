require 'rest-client'
require_relative 'repository'


module Chargers
  class Base
    attr_reader :data, :repo

    OK_STATUS = 200.freeze

    def initialize(data:, repo: Repository)
      @data = data
      @repo = repo
    end

    def charge(charge_url, payload, headers)
      begin
        res = RestClient.post(charge_url, payload, headers)
        handle_response(res)
      rescue RestClient::BadRequest => e
        update_error_counter(e.response)
        failure_result
      rescue StandardError => e
        update_error_counter(e.response)
        retry_result
      end
    end

    private
    def update_error_counter(reason)
      repo.update_error_counter(identifier, reason)
    end

    def create_error_counter(identifier, reason)
      repo.create_error_counter(identifier, reason)
    end

    def identifier
      @identifier ||= data[:identifier]
    end

    def full_name
      @full_name ||= data[:full_name]
    end

    def first_name
      @first_name ||= full_name.split(' ')[0]
    end

    def last_name
      @last_name ||= full_name.split(' ')[1]
    end

    def card_number
      @card_number ||= data[:card_number]
    end

    def expiration_date
      @expiration_date ||= data[:expiration_date]
    end

    def cvv
      @cvv ||= data[:cvv]
    end

    def amount
      @amount ||= data[:amount]
    end

    def success_result
      Struct.new(:card) do
        def success?
          true
        end

        def retriable?
          false
        end
      end.new
    end

    def failure_result
      Struct.new(:card) do
        def success?
          false
        end

        def retriable?
          false
        end
      end.new
    end

    def retry_result
      Struct.new(:card) do
        def success?
          false
        end

        def retriable?
          true
        end
      end.new
    end

  end
end