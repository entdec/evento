# frozen_string_literal: true

class Animal < ActiveRecord::Base
  state_machine initial: :sleeping do
  end
end
