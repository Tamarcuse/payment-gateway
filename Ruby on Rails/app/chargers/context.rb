require_relative 'factory'

module Chargers
  class Context
    attr_reader :data, :factory
    attr_accessor :attempt

    CHARGE_ATTEMPTS = 3.freeze

    def self.charge(data:, factory: Factory)
      new(
        data: data,
        factory: factory
      ).charge
    end

    def initialize(data:, factory:)
      @data = data
      @factory = factory
      @attempt = 0
    end

    def charge
      while attempt < CHARGE_ATTEMPTS
        @attempt = attempt + 1
        res = card_charger.charge
        break unless res.retriable?

        puts "Waiting #{attempt_wait_time} Seconds.."
        sleep(attempt_wait_time)
      end
      res
    end

    private

    def card_charger
      factory.instance(charger_type: data[:card_company]).new(data: data)
    end

    def attempt_wait_time
      attempt**2
    end

  end
end