# frozen_string_literal: true

class Scooter < ActiveRecord::Base
  has_many :transaction_log_entries, as: :transaction_loggable

  state_machine initial: :idle do
    event :start do
      transition idle: :engine_running
    end

    event :drive do
      transition engine_running: :driving
    end

    event :stop do
      transition %i[driving engine_running] => :idle
    end

    after_transition any => any do |car, transition|
      log_entry = TransactionLogEntry.new
      log_entry.transaction_loggable = car
      log_entry.event = transition.event
      log_entry.save!
    end
  end

  def stats
    { started: started, driven: driven, stopped: stopped }
  end
end
