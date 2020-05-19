# frozen_string_literal: true

require 'test_helper'

class ExtractorTest < Minitest::Test
  def test_without_options_extracts_nothing_from_test_aasm
    extractor = Evento::Extractor.new(TestAASM)
    assert_equal [], extractor.extract
  end

  def test_without_options_extracts_nothing_from_test_state_machines
    extractor = Evento::Extractor.new(TestStateMachines)
    assert_equal [], extractor.extract
  end

  def test_with_state_machine_option_extracts_aasm_events_from_test_aasm
    extractor = Evento::Extractor.new(TestAASM)
    assert_equal %w[run stop walk], extractor.extract(state_machine: true)
  end

  def test_with_state_machine_option_extracts_aasm_events_from_test_state_machines
    extractor = Evento::Extractor.new(TestStateMachines)
    assert_equal %w[drink fill], extractor.extract(state_machine: true)
  end

  def test_with_devise_option_extracts_devise_events_from_test_aasm
    extractor = Evento::Extractor.new(TestAASM)
    assert_equal ['confirmation_instructions',
                  'email_changed',
                  'password_change',
                  'reset_password_instructions',
                  'unlock_instructions'], extractor.extract(devise: true)
  end

  def test_with_devise_option_extracts_devise_events_from_test_state_machines
    extractor = Evento::Extractor.new(TestStateMachines)
    assert_equal ['confirmation_instructions',
                  'email_changed',
                  'password_change',
                  'reset_password_instructions',
                  'unlock_instructions'], extractor.extract(devise: true)
  end

  def test_with_both_options_extracts_devise_and_aasm_events_from_test_aasm
    extractor = Evento::Extractor.new(TestAASM)
    assert_equal ['confirmation_instructions',
                  'email_changed',
                  'password_change',
                  'reset_password_instructions',
                  'run',
                  'stop',
                  'unlock_instructions',
                  'walk'], extractor.extract(devise: true, state_machine: true)
  end

  def test_with_both_options_extracts_devise_and_aasm_events_from_test_state_machines
    extractor = Evento::Extractor.new(TestStateMachines)
    assert_equal ['confirmation_instructions',
                  'drink',
                  'email_changed',
                  'fill',
                  'password_change',
                  'reset_password_instructions',
                  'unlock_instructions'], extractor.extract(devise: true, state_machine: true)
  end
end
