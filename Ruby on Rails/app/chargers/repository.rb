module Chargers
  class Repository

    def self.update_error_counter(identifier, reason)
      error_counter = ErrorCounter.where(
        merchant: identifier,
        reason: reason
      ).first

      if error_counter.present?
        error_counter.count = error_counter.count + 1
        error_counter.save
      else
        create_error_counter(identifier, reason)
      end
    end

    def self.create_error_counter(identifier, reason)
      ErrorCounter.create(
        merchant: identifier,
        reason: reason,
        count: 1
      )
    end
  end
end