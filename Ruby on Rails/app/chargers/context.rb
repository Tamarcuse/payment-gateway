require_relative 'factory'

module Chargers
  class Context
    attr_reader :data, :factory

    def self.charge(data:, factory: Factory)
      new(
        data: data,
        factory: factory
      ).charge
    end

    def initialize(data:, factory:)
      @data = data
      @factory = factory
    end

    def charge
      card_charger.charge
    end

    private

    def card_charger
      factory.instance(charger_type: data[:card_company]).new(data: data)
    end

  end
end