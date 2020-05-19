# frozen_string_literal: true

require 'test_helper'

class ExtractorStateMachinesTest < Minitest::Test
  def test_without_options_extracts_nothing_from_test_state_machines
    extractor = Evento::Extractor.new(TestStateMachines)
    assert_equal [], extractor.extract_events
  end


  def test_with_state_machine_option_extracts_state_machines_events_from_test_state_machines
    extractor = Evento::Extractor.new(TestStateMachines)
    assert_equal %w[drink fill], extractor.extract_events(state_machine: true)
  end

  def test_with_devise_option_extracts_devise_events_from_test_state_machines
    extractor = Evento::Extractor.new(TestStateMachines)
    assert_equal ['confirmation_instructions',
                  'email_changed',
                  'password_change',
                  'reset_password_instructions',
                  'unlock_instructions'], extractor.extract_events(devise: true)
  end

  def test_with_both_options_extracts_devise_and_state_machines_events_from_test_state_machines
    extractor = Evento::Extractor.new(TestStateMachines)
    assert_equal ['confirmation_instructions',
                  'drink',
                  'email_changed',
                  'fill',
                  'password_change',
                  'reset_password_instructions',
                  'unlock_instructions'], extractor.extract_events(devise: true, state_machine: true)
  end
end
