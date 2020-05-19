# frozen_string_literal: true

class Car < ActiveRecord::Base
  state_machine initial: :idle do
    audit_trail class: ResourceStateTransition, as: :resource
  end
end
