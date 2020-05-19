# frozen_string_literal: true

class ResourceStateTransition < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
end
