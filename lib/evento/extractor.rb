# frozen_string_literal: true

module Evento
  class Extractor
    attr_reader :klass

    def initialize(klass)
      @klass = klass
    end

    def extract_audit_trail_association(options = {})
      name       = (options[:name] || :resource_state_transitions).to_sym
      reflection = klass.reflect_on_all_associations.find { |a| a.name == name } if klass.respond_to?(:reflect_on_all_associations)

      return reflection if options[:reflection]
      return reflection&.klass
    end

    def extract_events(options = {})
      events = []
      events += events_from_state_machine.map(&:to_s) if options[:state_machine]
      events += events_from_devise if options[:devise]
      events.sort
    end

    private

    def events_from_state_machine
      if klass.respond_to?(:aasm)
        klass.aasm.events.map(&:name)
      elsif klass.respond_to?(:state_machine) && klass.state_machine.respond_to?(:events)
        klass.state_machine.events.map(&:name)
      else
        []
      end
    end

    def events_from_devise
      I18n.t('devise.mailer').keys.map(&:to_s)
    end
  end
end
