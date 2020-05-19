# frozen_string_literal: true

require 'state_machines'

class TestStateMachines
  state_machine :state, initial: :empty do
    event :fill do
      transition %i[empty half_empty] => :full
    end

    event :drink do
      transition full: :half_empty
      transition half_empty: :empty
    end
  end
end
