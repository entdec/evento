# frozen_string_literal: true

class Car < ActiveRecord::Base
  state_machine initial: :idle do
    audit_trail class: ResourceStateTransition, as: :resource

    event :start do
      transition idle: :engine_running
    end

    event :drive do
      transition engine_running: :driving
    end

    event :stop do
      transition %i[driving engine_running] => :idle
    end
  end

  def stats
    { started: started, driven: driven, stopped: stopped }
  end
end
