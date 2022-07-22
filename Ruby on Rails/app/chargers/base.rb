require 'rest-client'

module Chargers
  class Base
    attr_reader :data

    OK_STATUS = 200.freeze

    def initialize(data:)
      @data = data
    end

    private
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
      end.new
    end

    def failure_result
      Struct.new(:card) do
        def success?
          false
        end
      end.new
    end

  end
end