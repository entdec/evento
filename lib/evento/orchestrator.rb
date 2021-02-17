# frozen_string_literal: true

module Evento
  class Orchestrator
    attr_reader :klass

    def initialize(klass, options = {})
      @klass     = klass
      @options   = options
      @extractor = nil
    end

    def after_transaction_log_commit(name, &block)
      association = extractor.extract_transaction_log_association
      after_association_commit(association, name, &block)
    end

    def after_audit_trail_commit(name, &block)
      association = extractor.extract_audit_trail_association(extract_audit_trail_options)
      after_association_commit(association, name, &block)
    end

    def define_event_methods_on(target_klass, options = {}, &block)
      extractor.extract_events(state_machine: options[:state_machine], devise: options[:devise])
               .reject { |event_name| target_klass.method_defined?(event_name) }
               .each do |event_name|
        target_klass.send(:define_method, event_name, &block)
      end

      return unless options[:life_cycle]

      %i[create destroy update save].each do |event_name|
        target_klass.send(:define_method, event_name, &block)
      end
    end

    def override_devise_notification(&block)
      klass.define_method(:send_devise_notification, block)
    end

    private

    def after_association_commit(association, name, &block)
      return unless association

      tracker = "#{association.name.underscore.gsub('/',
                                                    '__')}_after_commit_#{name.to_s.underscore.gsub('/', '__')}".upcase
      return if self.class.const_defined?(tracker, false)

      association.after_commit(&block)
      self.class.const_set(tracker, true)
    end

    def extract_audit_trail_options
      { name: @options[:audit_trail_name] }
    end

    def extractor
      return @extractor if @extractor

      @extractor = Extractor.new(klass)
    end
  end
end
