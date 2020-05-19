# frozen_string_literal: true

class Bicycle < ActiveRecord::Base
  state_machine initial: :idle do
    audit_trail class: Movement, as: :vehicle

    event :kick_off do
      transition idle: :cycling
    end

    event :brake do
      transition cycling: :idle
    end
  end
end
