module Presenters
  class ErrorCounterPresenter
    attr_reader :error_counter

    delegate :reason,
             :count, to: :error_counter

    def initialize(error_counter)
      @error_counter = error_counter
    end

    def as_json(args)
      {
        reason: reason,
        count: count
      }
    end

  end
end