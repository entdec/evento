# frozen_string_literal: true

require 'evento/version'

module Evento
  class Error < StandardError; end
end

require 'evento/extractor'
require 'evento/orchestrator'
