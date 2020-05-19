# frozen_string_literal: true

require 'aasm'

class TestAASM
  include AASM

  aasm do
    state :idle, initial: true
    state :running, :walking

    event :run do
      transitions from: %i[idle walking], to: :running
    end

    event :walk do
      transitions from: %i[idle running], to: :walking
    end

    event :stop do
      transitions from: %i[walking running], to: :idle
    end
  end
end
