# frozen_string_literal: true

class TransactionLogEntry < ActiveRecord::Base
  belongs_to :transaction_loggable, polymorphic: true
end

