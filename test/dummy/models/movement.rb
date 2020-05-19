# frozen_string_literal: true

class Movement < ActiveRecord::Base
  belongs_to :vehicle, polymorphic: true
end
