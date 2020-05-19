# frozen_string_literal: true

class Bicycle < ActiveRecord::Base
  state_machine initial: :idle do
    audit_trail class: Movement, as: :vehicle
  end
end
