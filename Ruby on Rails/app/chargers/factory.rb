require_relative 'visa'
require_relative 'master_card'

module Chargers
  class Factory

    CHARGERS_MAPPER = {
      'visa': Visa,
      'mastercard': MasterCard
    }.freeze

    def self.instance(charger_type:)
      CHARGERS_MAPPER[charger_type.to_sym]
    end
  end
end